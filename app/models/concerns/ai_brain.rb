module AiBrain
  def self.trace!
    currency_name_pairs = Mst::CurrencyPair.where(is_token: false).select{|pair| pair.pair_name.present? }.index_by(&:pair_name)
    EM.run do
      currency_name_pairs.each do |pair_name, currency_pair|
        ws_url = 'wss://ws.zaif.jp/stream?currency_pair=' + currency_pair.pair_name
        next if TraceConnection.where(state: [TraceConnection.states[:standby], TraceConnection.states[:opening]], url: ws_url, mst_currency_pair_id: currency_pair.id).exists?
        trade_connection = TraceConnection.create!(state: :standby, url: ws_url, mst_currency_pair_id: currency_pair.id)
        ws = Faye::WebSocket::Client.new(ws_url)

        ws.on :open do |event|
          trade_connection.update!(opened_time: Time.current, state: :opening)
          Batch.complement_trade_log!
        end

        ws.on :message do |event|
          trade_json = JSON.parse(event.data)
          self.input!(currency_name_pairs[trade_json["currency_pair"]], trade_json["trades"])
        end

        ws.on :close do |event|
          trade_connection.update!(closed_time: Time.current, state: :closed, closed_reason: [event.code, event.reason].join(" "))
          ws = nil
        end
      end
    end
  end

  def self.input!(currency_pair, trades_json_array)
    log_trades = trades_json_array.map do |trade_hash|
      Log::Trade.new(
        mst_exchange_id: currency_pair.mst_exchange_id,
        mst_currency_pair_id: currency_pair.id,
        tid: trade_hash["tid"],
        trade_method: trade_hash["trade_type"],
        price: trade_hash["price"],
        amount: trade_hash["amount"],
        traded_time: Time.at(trade_hash["date"])
      )
    end
    Log::Trade.import!(log_trades, on_duplicate_key_update: [:trade_method, :price, :amount, :traded_time])
    return log_trades
  end

  def self.imagine!

  end

  def self.judge!

  end
end