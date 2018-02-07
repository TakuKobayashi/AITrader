# == Schema Information
#
# Table name: wallets
#
#  id              :integer          not null, primary key
#  mst_exchange_id :integer          not null
#  mst_currency_id :integer          not null
#  amount          :float(24)        default(0.0), not null
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Wallet < ApplicationRecord
  def trade!(currency_pair:, price:, amount:, action:)
    currency_code, counter_currency_code  = currency_pair.pair_name.split("_")
    other_wallet = Wallet.find_by!(type: self.type, mst_currency_id: currency_pair.from_currency_id, mst_exchange_id: self.mst_exchange_id)
    trade_amount = price * amount
    api = Mst::Zaif.get_zaif_api
    json = api.trade(currency_code, price, amount, action, nil, counter_currency_code)
    self.update!(amount: other_wallet.amount - trade_amount)
    other_wallet.update!(amount: other_wallet.amount + trade_amount)
  end
end
