class AddMessagesToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :messages, :text
  end
end
