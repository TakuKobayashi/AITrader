module AiBrain
  def self.trace!
    currency_pair_names = Mst::CurrencyPair.where(is_token: false).pluck(:pair_name).select{|name| name.present? }
    EM.run do
      currency_pair_names.each do |pair_name|
        ws = Faye::WebSocket::Client.new('wss://ws.zaif.jp/stream?currency_pair=' + pair_name)

        ws.on :open do |event|
          p "open"
        end

        ws.on :message do |event|
          trade_json = JSON.parse(event.data)
          p trade_json["currency_pair"]
        end

        ws.on :close do |event|
          p "close #{event.code} #{event.reason}"
          ws = nil
        end
      end
    end
  end
end