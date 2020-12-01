class AddColumnsToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :full_name, :string
    add_column :authors, :uid, :string
    add_column :authors, :avatar_url, :string
  end
end
