# frozen_string_literal: true

# Terminal model
class Terminal < ApplicationRecord
  include Numberable
  include Undeletable

  validates :alias, presence: true, uniqueness: true

  def destroy
    errors.add(:base, :terminal_cannot_be_deleted)
  end

  def destroy!
    raise ActiveRecord::ReadOnlyRecord, 'Terminal cannot be deleted'
  end
end
