class CreatePayments < ActiveRecord::Migration
  def change
    create_table  :payments do |t|
      t.integer   :user_id
      t.string    :npwp
      t.integer   :amount
      t.boolean   :status
      t.text      :notification_params
      t.string    :status
      t.string    :transaction_id
      t.datetime  :purchased_at
      t.timestamps
    end
  end
end
