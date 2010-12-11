class CreateIssues < ActiveRecord::Migration
  def self.up
    create_table :issues do |t|
      t.references :service, :null => false
      t.string :title, :null => false
      t.integer :severity, :null => false
      t.text :description
      t.datetime :time_down
      t.string :estimate
      t.boolean :resolved, :default => false, :null => false
      t.datetime :time_up

      t.timestamps
    end
  end

  def self.down
    drop_table :issues
  end
end
