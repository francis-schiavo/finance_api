# frozen_string_literal: true

# Transaction model
class Transaction < ApplicationRecord
  include Unupdatable

  belongs_to :terminal
  belongs_to :account

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :timestamp, presence: true
end
