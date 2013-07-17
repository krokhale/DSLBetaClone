class CreateCoursemods < ActiveRecord::Migration
  def change
    create_table :coursemods do |t|
      t.string :module_name
      t.text :module_desc
      t.integer :course_id

      t.timestamps
    end
    add_index :coursemods, :course_id
  end
  
  def self.down
    drop_table :coursemods
  end
end
