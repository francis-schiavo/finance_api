# frozen_string_literal: true

# Terminal model migration
class CreateTerminals < ActiveRecord::Migration[7.2]
  def change
    create_table :terminals, id: :uuid do |t|
      t.string :number, null: false, limit: 8
      t.string :alias, null: false

      t.timestamps

      t.index :number, unique: true
      t.index :alias, unique: true
    end
  end
end
