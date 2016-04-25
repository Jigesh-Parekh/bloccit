class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
    	t.string :name
    	t.timestamp null: false

    end
  end
end
