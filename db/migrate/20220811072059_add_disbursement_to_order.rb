class AddDisbursementToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :disbursement, foreign_key: true
  end
end
