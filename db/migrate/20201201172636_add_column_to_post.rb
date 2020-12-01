class AddColumnToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :finished, :boolean, :default =>  false

  end
end
