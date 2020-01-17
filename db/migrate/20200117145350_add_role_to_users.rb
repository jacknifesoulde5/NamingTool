class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roll, :integer, null: false,default: 1
  end
end
