class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :handle
      table.string :email
      table.string :password
      table.string :fname
      table.string :lname
      table.datetime :birthday
      table.string :station
      table.text :bio
      table.string :image
    end
  end
end
