class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :role
      t.string :course
      t.string :user
      t.string :micropost

      t.timestamps
    end
    add_index :authorizations, :role
  end
end
