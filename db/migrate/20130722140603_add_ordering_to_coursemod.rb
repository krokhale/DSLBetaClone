class AddOrderingToCoursemod < ActiveRecord::Migration
  def change
    add_column :coursemods, :order, :integer
  end
end
