# frozen_string_literal: true

# Prevents deletion of records
module Undeletable
  extend ActiveSupport::Concern

  def destroy
    errors.add(:base, :cannot_be_deleted)
  end

  def destroy!
    raise ActiveRecord::ReadOnlyRecord, 'Record cannot be deleted'
  end
end
