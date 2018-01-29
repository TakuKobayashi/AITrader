module Batch
  def self.import_ticker!
    zaif = Mst::Zaif.first
    zaif.import_price_ticker!
  end
end