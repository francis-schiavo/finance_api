# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @person = people(:john)
  end

  test 'should create account' do
    account = Account.new(person: @person, balance: 0)

    assert account.save
  end

  test 'should not create account without person' do
    account = Account.new(balance: 0)

    assert_not account.save
  end

  test 'should not create account without balance' do
    account = Account.new(person: @person)

    assert_not account.save
  end

  test 'should not create account with negative balance' do
    account = Account.new(person: @person, balance: -1)

    assert_not account.save
  end

  test 'should generate account number' do
    account = Account.create(person: @person, balance: 0)

    assert_not_nil account.number
  end

  test 'should have active status' do
    account = Account.create(person: @person, balance: 0)

    assert_predicate account, :active?
  end

  test 'should update account' do
    account = accounts(:account_one)
    account.update(balance: 100)

    assert_equal 100, account.balance
  end

  test 'should not update account without person' do
    account = accounts(:account_one)
    account.update(person: nil)

    assert_not account.save
  end

  test 'should not update account without balance' do
    account = accounts(:account_one)
    account.update(balance: nil)

    assert_not account.save
  end

  test 'should not destroy any account' do
    account = accounts(:account_one)
    account.destroy

    assert_not account.destroyed?

    assert_raise ActiveRecord::ReadOnlyRecord do
      account.destroy!
    end
  end
end
