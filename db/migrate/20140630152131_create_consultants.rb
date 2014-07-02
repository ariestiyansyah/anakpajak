class CreateConsultants < ActiveRecord::Migration
  def change
    create_table :consultants do |t|
      t.string    :title
      t.text      :address
      t.text      :description
      t.string    :region
      t.integer   :latitude
      t.integer   :longitude
      t.timestamps
    end
  end
end
