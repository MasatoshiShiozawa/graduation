class CreateSpecialCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :special_category_relations do |t|
      t.integer :special_id
      t.integer :category_id

      t.timestamps
    end
  end
end
