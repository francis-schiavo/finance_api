# frozen_string_literal: true

# Person model
class Person < ApplicationRecord
  has_many :accounts, dependent: :restrict_with_error

  validates :name, :last_name, :birthday, presence: true
end
