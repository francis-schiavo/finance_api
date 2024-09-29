# frozen_string_literal: true

# Support for generating unique numbers for models
module Numberable
  extend ActiveSupport::Concern

  included do
    attr_readonly :number

    before_create :generate_number
  end

  def generate_number
    last_number = self.class.select(%i[number]).order(:number).last.number.to_i
    self.number = format '%08d', last_number.next
  end
end
