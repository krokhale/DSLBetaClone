class RenameModuleLessons < ActiveRecord::Migration
  def up
    rename_table :module_lessons, :modlesson
  end

  def down
  end
end
