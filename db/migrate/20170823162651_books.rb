class Books < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :ISBN
      t.integer :course_id
    end
  end
end
