class CreateShoppers < ActiveRecord::Migration[6.1]
  def change
    create_table :shoppers do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :nif, null: false

      t.timestamps
    end
  end
end
