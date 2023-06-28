class AddUniqueIndexUsernameToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_index :customers, :username, unique: true
  end
end
