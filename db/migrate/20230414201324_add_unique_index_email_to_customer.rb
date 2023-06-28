class AddUniqueIndexEmailToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_index :customers, :email, unique: true
  end
end
