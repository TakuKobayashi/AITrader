module Batch
  def self.import_ticker!
    zaif = Mst::Zaif.first
    zaif.import_price_ticker!
  end

  def self.complement_trade_log!
    opening_trade_connections = TraceConnection.opening
    id_pairs = Mst::CurrencyPair.where(id: opening_trade_connections.map(&:mst_currency_pair_id)).index_by(&:id)
    opening_trade_connections.each do |otc|
      before_connection = TraceConnection.closed.where(url: otc.url).where("closed_time < ?", otc.opened_time).last
      trades_json = RequestParser.request_and_parse_json(url: "https://api.zaif.jp/api/1/trades/" + id_pairs[otc.mst_currency_pair_id].pair_name)
      depth_json = RequestParser.request_and_parse_json(url: "https://api.zaif.jp/api/1/depth/" + id_pairs[otc.mst_currency_pair_id].pair_name)
      AiBrain.input!(
        currency_pair: id_pairs[otc.mst_currency_pair_id],
        trades_json_array: trades_json,
        asks_json_array: depth_json["asks"],
        bids_json_array: depth_json["bids"]
      )
    end
    TraceConnection.closed.update_all(state: :expired)
  end
end