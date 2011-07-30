class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
