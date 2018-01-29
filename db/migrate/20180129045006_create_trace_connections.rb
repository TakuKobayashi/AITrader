class CreateTraceConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :trace_connections do |t|
      t.integer :mst_currency_pair_id
      t.integer :state, null: false, default: 0
      t.string :url, null: false
      t.datetime :opened_time
      t.datetime :closed_time
      t.text :closed_reason
    end
    add_index :trace_connections, :url
    add_index :trace_connections, :opened_time
    add_index :trace_connections, :closed_time
  end
end
