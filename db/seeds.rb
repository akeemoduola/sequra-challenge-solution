require 'csv'

merchants = CSV.foreach(Rails.root.join('lib/csvs/merchants.csv')).map do |row|
  {
    id: row[0].to_i,
    name: row[1],
    email: row[2],
    cif: row[3]
  }
end
puts merchants
puts "-------------------------------------------------------------------------------------------------------------"

Merchant.create_with(created_at: DateTime.parse("Mon, 01 Jan 2018"), updated_at: DateTime.parse("Mon, 01 Jan 2018")).insert_all!(merchants)
puts "Created/Inersted #{Merchant.count} merchants"

shoppers = CSV.foreach(Rails.root.join('lib/csvs/shoppers.csv')).map do |row|
  {
    id: row[0].to_i,
    name: row[1],
    email: row[2],
    nif: row[3]
  }
end
puts shoppers
puts "-------------------------------------------------------------------------------------------------------------"

Shopper.create_with(created_at: DateTime.parse("Mon, 01 Jan 2018"), updated_at: DateTime.parse("Mon, 01 Jan 2018")).insert_all!(shoppers)
puts "Created/Inserted #{Shopper.count} shoppers"

orders = CSV.foreach(Rails.root.join('lib/csvs/orders.csv')).map do |row|
  {
    id: row[0].to_i,
    merchant_id: row[1],
    shopper_id: row[2],
    amount: row[3],
    created_at: row[4],
    updated_at: row[4],
    completed_at: row[5]
  }
end

Order.insert_all!(orders)
puts "Created/Inserted #{Order.count} orders"
  
#unique dates from given orders data
dates = ["Mon, 01 Jan 2018", "Mon, 08 Jan 2018", "Mon, 15 Jan 2018", 
  "Mon, 22 Jan 2018", "Mon, 29 Jan 2018", "Mon, 05 Feb 2018", "Mon, 12 Feb 2018", 
  "Mon, 19 Feb 2018", "Mon, 26 Feb 2018", "Mon, 05 Mar 2018", "Mon, 12 Mar 2018", 
  "Mon, 19 Mar 2018", "Mon, 26 Mar 2018", "Mon, 02 Apr 2018"]
    
dates.each do |date| 
  start_date = DateTime.parse(date)
  merchants = Merchant.weekly_completed_orders_for(start_date)
  merchants.each do |merchant|
    new_disbursement_hash = {
      merchant: merchant,
      total_disburse_amount: merchant.orders.reduce(0) {|t, order| t + order.net_amount},
      week: start_date.cweek
    }
    ActiveRecord::Base.transaction do
      disbursement = Disbursement.create(new_disbursement_hash)
      
      orders = merchant.orders.map do |order| 
        order.update(disbursement_id: disbursement.id)
        order
      end
      disbursement.orders =  orders
      disbursement.save
    end
  end
end

puts "Seeded #{Disbursement.count} disbursements"