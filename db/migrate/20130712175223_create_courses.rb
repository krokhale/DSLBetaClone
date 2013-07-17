class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :technology
      t.string :level

      t.timestamps
    end
    
  end
  
  def self.down
    drop_table :microposts
  end
end
