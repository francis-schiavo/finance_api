# frozen_string_literal: true

# Person model
class Person < ApplicationRecord
  validates :name, :last_name, :birthday, presence: true
end
