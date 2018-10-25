class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|

      t.date :date
      t.integer :number
      t.integer :budget
      t.string :ngact
      t.integer :active
      t.integer :loose
      t.integer :user_id
      t.timestamps
    end
  end
end
