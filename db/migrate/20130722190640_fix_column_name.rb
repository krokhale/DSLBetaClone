class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :coursemods, :order, :coursemod_order
  end

  def down
  end
end
