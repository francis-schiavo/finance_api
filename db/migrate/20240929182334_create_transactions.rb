# frozen_string_literal: true

# Transaction model migration
class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :terminal, null: false, foreign_key: true, type: :uuid
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.datetime :timestamp, null: false

      t.timestamps
    end
  end
end
