class CreateUsersTable < ActiveRecord::Migration
  def change
     create_table 'users' do |u|
      u.string :username
      u.integer :password
      u.integer :bob
      u.string :fname
      u.string :lname
      u.string :email
      u.text :gender 
    end
  end
end
