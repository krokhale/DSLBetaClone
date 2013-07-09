class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :description
      t.text :instructions
      t.text :solution

      t.timestamps
    end
  end
end
