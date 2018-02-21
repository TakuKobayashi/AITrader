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
  belongs_to :exchange, class_name: 'Mst::Exchange', foreign_key: :mst_exchange_id, required: false
  belongs_to :currency, class_name: 'Mst::Currency', foreign_key: :mst_currency_id, required: false
  has_many :movements, class_name: 'Log::WalletMovement', foreign_key: :wallet_id
  has_many :order_logs, class_name: 'Log::SelfTradeOrder', foreign_key: :from_wallet_id

  def order!(currency_pair:, price:, amount:, action:)
    other_wallet = Wallet.find_by!(type: self.type, mst_currency_id: currency_pair.from_currency_id, mst_exchange_id: self.mst_exchange_id)
    order_log = self.order_logs.new(
      mst_exchange_id: self.mst_exchange_id,
      trade_method: action.to_s,
      to_wallet_id: other_wallet.id,
      price: price,
      amount: amount
    )
    order_log.order!(currency_pair: currency_pair)
    return order_log
  end
end
