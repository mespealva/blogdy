class AddTagToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :tag, null: false, foreign_key: true
  end
end
