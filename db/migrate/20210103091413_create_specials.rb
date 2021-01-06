class CreateSpecials < ActiveRecord::Migration[5.2]
  def change
    create_table :specials do |t|
      t.string :product
      t.string :company
      t.text :image
      t.string :detail
      t.float :per
      t.string :status
      t.integer :price
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
