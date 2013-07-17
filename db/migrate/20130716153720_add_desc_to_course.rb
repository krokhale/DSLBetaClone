class AddDescToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :desc, :text
  end
end
