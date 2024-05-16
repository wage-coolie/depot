class RenameDescriptionToDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :description, :description
  end
end
