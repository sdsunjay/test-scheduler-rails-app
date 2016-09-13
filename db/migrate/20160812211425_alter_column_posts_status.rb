class AlterColumnPostsStatus < ActiveRecord::Migration
    def self.up
        change_table :posts do |t|
            t.change :status, :integer, :default => 0
        end
    end
    def self.down
        change_table :posts do |t|
            t.change :status, :integer
        end
    end
end
