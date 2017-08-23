class AddGradeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :grade_level, :integer
  end
end
