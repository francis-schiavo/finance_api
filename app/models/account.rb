# frozen_string_literal: true

# Account model
class Account < ApplicationRecord
  include Numberable
  include Undeletable

  belongs_to :person

  validates :balance, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }, on: :create

  enum :status, { active: 1, locked: 2, terminated: 3 }
end
