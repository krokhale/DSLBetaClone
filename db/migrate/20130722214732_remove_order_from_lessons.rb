class RemoveOrderFromLessons < ActiveRecord::Migration
  def up
    remove_column :lessons, :order
  end

  def down
  end
end
