class AddQuantityToAlbumOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :album_orders, :quantity, :integer
  end
end
