# frozen_string_literal: true

# Person model migration
class CreatePeople < ActiveRecord::Migration[7.2]
  def change
    create_table :people, id: :uuid do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.date :birthday, null: false

      t.timestamps
    end
  end
end
