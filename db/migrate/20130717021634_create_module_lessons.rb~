class CreateModuleLessons < ActiveRecord::Migration
  def change
    create_table :module_lessons do |t|
      t.integer :module_id
      t.integer :lesson_id

      t.timestamps
    end
    add_index :module_lessons, :module_id
    add_index :module_lessons, :lesson_id
  end
  
  def self.down
    drop_table :module_lessons
  end
end
