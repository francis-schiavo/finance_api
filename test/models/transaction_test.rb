# frozen_string_literal: true

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = transactions(:one)
    @transaction_data = @transaction.attributes.slice('terminal_id', 'account_id', 'amount', 'timestamp')
  end

  test 'should save transaction' do
    transaction = Transaction.new @transaction_data

    assert transaction.save
  end

  test 'should not save transaction without terminal_id' do
    transaction = Transaction.new @transaction_data.except('terminal_id')

    assert_not transaction.save
  end

  test 'should not save transaction without account_id' do
    transaction = Transaction.new @transaction_data.except('account_id')

    assert_not transaction.save
  end

  test 'should not save transaction without amount' do
    transaction = Transaction.new @transaction_data.except('amount')

    assert_not transaction.save
  end

  test 'should not save transaction without timestamp' do
    transaction = Transaction.new @transaction_data.except('timestamp')

    assert_not transaction.save
  end

  test 'should not save transaction with negative amount' do
    transaction = Transaction.new @transaction_data.merge('amount' => -1)

    assert_not transaction.save
  end

  test 'should not save transaction with zero amount' do
    transaction = Transaction.new @transaction_data.merge('amount' => 0)

    assert_not transaction.save
  end

  test 'should not update transaction' do
    assert_raises ActiveRecord::ReadOnlyRecord do
      @transaction.update(@transaction_data)
    end

    @transaction.amount = 100
    assert_raises ActiveRecord::ReadOnlyRecord do
      @transaction.save
    end
  end

  test 'should not destroy transaction' do
    transaction = transactions(:deletable)

    assert_raises ActiveRecord::ReadOnlyRecord do
      @transaction.destroy
    end

    assert_raises ActiveRecord::ReadOnlyRecord do
      transaction.destroy!
    end
  end
end
