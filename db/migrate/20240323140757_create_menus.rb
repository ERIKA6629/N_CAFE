class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      
      t.timestamps
      
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_sold_out, null: false, default: false
    end
  end
end
