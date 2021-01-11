class CreateSuiis < ActiveRecord::Migration[5.2]
  def change
    create_table :suiis do |t|
      t.references :special, foreign_key: true
      t.datetime :date_friday
      t.integer :weekly_closing_price
      t.timestamps
    end
  end
end
