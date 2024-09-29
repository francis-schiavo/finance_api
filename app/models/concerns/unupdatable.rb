# frozen_string_literal: true

# Prevents deletion of records
module Unupdatable
  extend ActiveSupport::Concern

  def readonly?
    !new_record?
  end
end
