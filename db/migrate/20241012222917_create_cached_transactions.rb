# frozen_string_literal: true

# Transaction cache migration
class CreateCachedTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :cached_transactions, id: :uuid do |t|
      t.string :cacheable_type, null: false
      t.uuid :cacheable_id, null: false
      t.uuid :request_id, null: false
      t.jsonb :payload, null: false

      t.timestamps

      t.index %i[cacheable_type cacheable_id]
      t.index :request_id, unique: true
    end
  end
end
