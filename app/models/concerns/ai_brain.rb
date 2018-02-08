module AiBrain
  def self.trace!
    #Process.daemon
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
          self.input!(
            currency_pair: currency_name_pairs[trade_json["currency_pair"]],
            trades_json_array: trade_json["trades"],
            asks_json_array: trade_json["asks"],
            bids_json_array: trade_json["bids"]
          )
        end

        ws.on :close do |event|
          trade_connection.update!(closed_time: Time.current, state: :closed, closed_reason: [event.code, event.reason].join(" "))
          ws = nil
        end
      end
    end
  end

  def self.input!(currency_pair:, trades_json_array: [], asks_json_array: [], bids_json_array: [])
    log_trades = trades_json_array.map do |trade_hash|
      trade_time = Time.at(trade_hash["date"])
      log_trade = Log::Trade.new(
        mst_exchange_id: currency_pair.mst_exchange_id,
        mst_currency_pair_id: currency_pair.id,
        tid: trade_hash["tid"],
        trade_method: trade_hash["trade_type"],
        price: trade_hash["price"],
        amount: trade_hash["amount"],
        traded_time: trade_time
      )
      log_trade.section = trade_time
      log_trade
    end
    if log_trades.present?
      Log::Trade.import!(log_trades, on_duplicate_key_update: [:trade_method, :price, :amount])
    end
    current_time = Time.current
    log_indicatives = asks_json_array.map do |price, amount|
      log_price = Log::IndicativePrice.new(
        group_number: current_time.to_i,
        offer_action: :ask,
        price: price,
        amount: amount
      )
      log_price.section = current_time
      log_price
    end
    log_indicatives += bids_json_array.map do |price, amount|
      log_price = Log::IndicativePrice.new(
        group_number: current_time.to_i,
        offer_action: :bid,
        price: price,
        amount: amount
      )
      log_price.section = current_time
      log_price
    end
    if log_indicatives.present?
      Log::IndicativePrice.import!(log_indicatives, on_duplicate_key_update: [:amount, :offer_action])
    end
  end

  SHORT_IMAGINE_SPAN = 30.minutes
  LONG_IMAGINE_SPAN = 12.hour
  SPLIT_GROUP_COUNT = 4
  # 価格の変動率がこの値以上だと急激に変化したと見る
  RAPIDLY_RATE = 0.01

  def self.imagine!(span:)
    zaif = Mst::Zaif.first
    pair = zaif.currency_pairs.find_by(pair_name: "xem_jpy")
    all_trade_logs = Log::Trade.
      where(mst_exchange_id: zaif.id, mst_currency_pair_id: pair.id).
      where("traded_time > ?", (span * SPLIT_GROUP_COUNT).ago).
      order("traded_time DESC")
    span_splits = (0..SPLIT_GROUP_COUNT).to_a.map{|i| ((i + 1) * span).ago..(i * span).ago }
    trade_log_groups = all_trade_logs.group_by do |trade_log|
      span_splits.find_index{|span_range| span_range.cover?(trade_log.traded_time) }
    end
    judge_result = self.judge(trade_log_groups: trade_log_groups)
    self.enforce!(judge_result: judge_result)
  end

  def self.judge(trade_log_groups: {})
    result = {}
    # 判断する際の抽選確率(0より低ければ買おうかな?, 0より高ければ売ろうかな?という指標)
    lot_rate = 0
    # 投資する金額の割合
    pay_rate = 0
    # 前と比べて上がっている
    diff1 = trade_logs[0].price - trade_logs[1].price
    if diff1.abs > later_log.price * RAPIDLY_RATE
      lot_rate = 0.5
      pay_rate = 0.5
    end
    if diff1 < 0
      lot_rate = -lot_rate
    end

    diff2 = trade_logs[1].price - trade_logs[2].price
    if diff1 < 0
      if diff2 < 0
      end
    else
      if diff2 < 0
      end
    end

    #確率が0より低ければ買う、0より高ければ売る
    action = nil
    if lot_rate < 0
      action = "bid"
    elsif lot_rate > 0
      action = "ask"
    end
    return OpenStruct.new(result)
  end

  def self.enforce!(judge_result:)

  end
end