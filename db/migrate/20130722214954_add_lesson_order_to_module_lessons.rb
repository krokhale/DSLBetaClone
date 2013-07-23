class AddLessonOrderToModuleLessons < ActiveRecord::Migration
  def change
   add_column :module_lessons, :lesson_order, :integer
  end
end
