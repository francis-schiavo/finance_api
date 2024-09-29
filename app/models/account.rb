# frozen_string_literal: true

# Account model
class Account < ApplicationRecord
  belongs_to :person

  validates :balance, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }, on: :create

  enum :status, { active: 1, locked: 2, terminated: 3 }

  before_create :generate_number

  def destroy
    errors.add(:base, :accounts_cannot_be_deleted)
  end

  def destroy!
    raise ActiveRecord::ReadOnlyRecord, 'Accounts cannot be deleted'
  end

  private

  def generate_number
    last_account_number = self.class.select(%i[number]).order(:number).last.number.to_i
    self.number = format '%08d', last_account_number.next
  end
end
