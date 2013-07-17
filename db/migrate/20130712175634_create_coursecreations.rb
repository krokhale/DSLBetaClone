class CreateCoursecreations < ActiveRecord::Migration
  def self.up
    create_table :coursecreations do |t|
      t.integer :course_id
      t.integer :user_id
      t.string :role
      t.timestamps
    end
    add_index :coursecreations, :course_id
    add_index :coursecreations, :user_id
        
  end

  def self.down
    drop_table :coursecreations
  end
end
