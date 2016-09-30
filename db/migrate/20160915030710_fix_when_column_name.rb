class FixWhenColumnName < ActiveRecord::Migration
  def change
   rename_column :posts, :when, :when_date
  end
end
