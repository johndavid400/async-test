class CreateWidgets < ActiveRecord::Migration[6.1]
  def change
    create_table :widgets do |t|
      t.string :name
      t.integer :option_id, default: 0

      t.timestamps
    end
  end
end
