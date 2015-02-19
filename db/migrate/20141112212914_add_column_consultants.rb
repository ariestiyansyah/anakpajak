class AddColumnConsultants < ActiveRecord::Migration
  def change
    add_column :consultants, :no_registration,  :string
    add_column :consultants, :no_telp,          :string
    add_column :consultants, :email,            :string
    add_column :consultants, :website,          :string
    add_column :consultants, :city,             :string
  end
end
