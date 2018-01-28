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
  end
end
