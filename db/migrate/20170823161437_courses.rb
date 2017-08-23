class Courses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :semester
      t.integer :user_id
    end
  end
end
