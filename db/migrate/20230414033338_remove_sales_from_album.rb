class RemoveSalesFromAlbum < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :sales, :integer
  end
end
