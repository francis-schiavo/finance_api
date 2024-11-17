# frozen_string_literal: true

# Account model migration
class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :person, null: false, foreign_key: true, type: :uuid
      t.string :number, null: false, limit: 8
      t.decimal :balance, null: false, precision: 10, scale: 2
      t.integer :status, null: false, default: 1

      t.timestamps

      t.index :number, unique: true
    end
  end
end
