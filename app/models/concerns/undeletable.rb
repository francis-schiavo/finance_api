# frozen_string_literal: true

# Prevents deletion of records
module Undeletable
  extend ActiveSupport::Concern

  included do
    before_destroy :prevent_destruction
  end

  def prevent_destruction
    raise ActiveRecord::ReadOnlyRecord, 'Record cannot be deleted'
  end
end
