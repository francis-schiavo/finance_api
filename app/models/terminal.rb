# frozen_string_literal: true

# Terminal model
class Terminal < ApplicationRecord
  include Numberable
  include Undeletable

  validates :alias, presence: true, uniqueness: true
end
