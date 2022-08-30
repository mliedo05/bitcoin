class CreateCryptos < ActiveRecord::Migration[7.0]
  def change
    create_table :cryptos do |t|
      t.string :data
      t.string :prev_block
      t.integer :block_index
      t.integer :time
      t.integer :bits

      t.timestamps
    end
  end
end
