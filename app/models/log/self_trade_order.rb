# == Schema Information
#
# Table name: log_self_trade_orders
#
#  id              :integer          not null, primary key
#  state           :integer          default(0), not null
#  mst_exchange_id :integer          not null
#  tid             :string(255)      not null
#  trade_method    :string(255)      not null
#  from_wallet_id  :integer          not null
#  to_wallet_id    :integer          not null
#  price           :float(24)        default(0.0), not null
#  amount          :float(24)        default(0.0), not null
#  traded_at       :datetime
#  canceled_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_log_self_trade_orders_on_tid_and_mst_exchange_id  (tid,mst_exchange_id) UNIQUE
#

class Log::SelfTradeOrder < ApplicationRecord
  belongs_to :exchange, class_name: 'Mst::Exchange', foreign_key: :mst_exchange_id, required: false
  belongs_to :from_wallet, class_name: 'Wallet', foreign_key: :from_wallet_id, required: false
  belongs_to :to_wallet, class_name: 'Wallet', foreign_key: :to_wallet_id, required: false
  has_many :movements, class_name: 'Log::WalletMovement', foreign_key: :log_self_trade_order_id

  enum state: {
    unknown: 0,
    active: 1,
    traded: 2,
    canceled: 3
  }

  def order!(currency_pair:)
    currency_code, counter_currency_code = currency_pair.pair_name.split("_")
    api = Mst::Zaif.get_zaif_api
    json = api.trade(currency_code, self.price, self.amount, self.trade_method, nil, counter_currency_code)
    order_ids = json["return"].keys
    order_ids.each do |order_id|
      self.movements.create!(
        movement_state: :active,
        wallet_id: from_wallet.id,
        before_amount: from_wallet.amount,
        after_amount from_wallet.amount - (self.amount * self.price),
        move_amount: (self.amount * self.price)
      )
      from_wallet.update!(amount: other_wallet.amount - trade_amount)
      update!(tid: order_id, state: :active)
    end
  end

  def order_cancel!
    unless active?
      return nil
    end
    api = Mst::Zaif.get_zaif_api
    json = api.cancel(self.tid)
    transaction do
      self.movements.create!(
        movement_state: :canceled,
        wallet_id: from_wallet.id,
        before_amount: from_wallet.amount,
        after_amount from_wallet.amount + (self.amount * self.price),
        move_amount: (self.amount * self.price)
      )
      from_wallet.update!(amount: from_wallet.amount + (self.amount * self.price))
      update!(state: :canceled, canceled_at: Time.current)
    end
  end

  def tarde!
    unless active?
      return nil
    end
    transaction do
      self.movements.create!(
        movement_state: :traded,
        wallet_id: to_wallet.id,
        before_amount: to_wallet.amount,
        after_amount to_wallet.amount + self.amount,
        move_amount: self.amount
      )
      to_wallet.update!(amount: to_wallet.amount + self.amount)
      update!(state: :traded, traded_at: Time.current)
    end
  end
end
