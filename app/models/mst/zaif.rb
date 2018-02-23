# == Schema Information
#
# Table name: mst_exchanges
#
#  id                    :integer          not null, primary key
#  type                  :string(255)      not null
#  name                  :string(255)      not null
#  url                   :string(255)      not null
#  max_maker_spread_rate :float(24)        default(0.0), not null
#  max_taker_spread_rate :float(24)        default(0.0), not null
#

class Mst::Zaif < Mst::Exchange
  def setup!
    currency_json = RequestParser.request_and_parse_json(url: "https://api.zaif.jp/api/1/currencies/all")
    currency_name_hash = {}
    currency_json.each do |cjson|
      currency = self.currencies.find_or_initialize_by(cid: cjson["id"])
      currency.update!(name: cjson["name"])
      currency_name_hash[currency.name.downcase] = currency
    end
    currency_pair_json = RequestParser.request_and_parse_json(url: "https://api.zaif.jp/api/1/currency_pairs/all")
    currency_pair_json.each do |cpjson|
      currency_pair = self.currency_pairs.find_or_initialize_by(cpid: cpjson["id"])
      from_name, to_name = cpjson["currency_pair"].to_s.downcase.split("_")
      if currency_name_hash[from_name].present? && currency_name_hash[to_name].present?
        currency_pair.update!(
          from_currency_id: currency_name_hash[from_name].id,
          to_currency_id: currency_name_hash[to_name].id,
          name: cpjson["name"],
          pair_name: cpjson["currency_pair"],
          is_token: cpjson["is_token"],
          description: cpjson["description"]
        )
      end
    end
    update_wallet!
  end

  def update_wallet!
    api = Mst::Zaif.get_api_client
    info_json = api.get_info
    name_currencies = Mst::Currency.where(name: info_json["funds"].keys).index_by(&:name)
    info_json["funds"].each do |currency_name, amount|
      hot_wallet = self.wallets.find_or_initialize_by(type: 'HotWallet', mst_currency_id: name_currencies[currency_name].id)
      hot_wallet.update!(amount: amount.to_f / 2)
      cold_wallet = self.wallets.find_or_initialize_by(type: 'ColdWallet', mst_currency_id: name_currencies[currency_name].id)
      cold_wallet.update!(amount: amount.to_f / 2)
    end
  end

  def import_price_ticker!
    mst_currency_pairs = self.currency_pairs.where(is_token: false)
    price_tickers = mst_currency_pairs.map do |currency_pair|
      ticker_json = RequestParser.request_and_parse_json(url: "https://api.zaif.jp/api/1/ticker/" + currency_pair.pair_name)
      PriceTicker.create!(
        mst_exchange_id: self.id,
        mst_currency_pair_id: currency_pair.id,
        high_price: ticker_json["high"],
        low_price: ticker_json["low"],
        last_price: ticker_json["last"],
        vwap: ticker_json["vwap"],
        sign_bid: ticker_json["bid"],
        sign_ask: ticker_json["ask"],
      )
    end
    return price_tickers
  end

  def self.get_api_client
    api = Zaif::API.new(:api_key => ENV.fetch('TWITTER_CONSUMER_KEY', 'ZAIF_AITRADER_KEY'), :api_secret => ENV.fetch('TWITTER_CONSUMER_KEY', 'ZAIF_AITRADER_SECRET'))
    return api
  end
end
