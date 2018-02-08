# == Schema Information
#
# Table name: log_wallet_movements
#
#  id            :integer          not null, primary key
#  wallet_id     :integer          not null
#  before_amount :float(24)        default(0.0), not null
#  after_amount  :float(24)        default(0.0), not null
#  move_amount   :float(24)        default(0.0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_log_wallet_movements_on_created_at  (created_at)
#  index_log_wallet_movements_on_wallet_id   (wallet_id)
#

class Log::WalletMovement < ApplicationRecord
  belongs_to :wallet, class_name: 'Wallet', foreign_key: :wallet_id, required: false
end
