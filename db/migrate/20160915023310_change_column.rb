class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :posts, :when, :datetime, :null => false, :default => Time.now
  end
end
