class AddTipsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :tips, :text
  end
end
