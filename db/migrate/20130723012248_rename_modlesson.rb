class RenameModlesson < ActiveRecord::Migration
  def up
    rename_table :modlesson, :modlessons
  end

  def down
  end
end
