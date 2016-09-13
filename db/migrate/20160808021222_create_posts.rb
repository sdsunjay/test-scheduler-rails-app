class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :number_of_buyers
      t.integer :status
      t.date :when

      t.timestamps null: false
    end
  end
end
