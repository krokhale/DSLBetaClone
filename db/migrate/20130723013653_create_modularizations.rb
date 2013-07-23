class CreateModularizations < ActiveRecord::Migration
  def change
    create_table :modularizations do |t|
      t.integer :module_id
      t.integer :lesson_id
      t.integer :lesson_order

      t.timestamps
    end
  end
end
