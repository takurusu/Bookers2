class RemoveTitleIdFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :title_id, :string
  end
end
