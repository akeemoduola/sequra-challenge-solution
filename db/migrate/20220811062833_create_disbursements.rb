class CreateDisbursements < ActiveRecord::Migration[6.1]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false, foreign_key: true
      t.decimal :total_disburse_amount, null: false, default: 0
      t.integer :week, null: false, index: true

      t.timestamps
    end
  end
end
