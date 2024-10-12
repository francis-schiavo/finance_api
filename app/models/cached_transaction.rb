# frozen_string_literal: true

# Cached transaction model
class CachedTransaction < ApplicationRecord
  include Unupdatable
  belongs_to :cacheable, polymorphic: true

  validates :request_id, presence: true, uniqueness: true
  validates :payload, presence: true
end
