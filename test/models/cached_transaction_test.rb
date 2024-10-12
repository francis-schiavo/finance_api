# frozen_string_literal: true

require 'test_helper'

class CachedTransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = transactions(:one)
    @uuid = SecureRandom.uuid
  end

  test 'should create a cached transaction' do
    cached_transaction = CachedTransaction.new(
      cacheable: @transaction,
      request_id: @uuid,
      payload: @transaction.as_json
    )

    assert cached_transaction.save
  end

  test 'should not create a cached transaction without a cacheable' do
    cached_transaction = CachedTransaction.new(
      request_id: @uuid,
      payload: @transaction.as_json
    )

    assert_not cached_transaction.save
  end

  test 'should not create a cached transaction without a request_id' do
    cached_transaction = CachedTransaction.new(
      cacheable: @transaction,
      payload: @transaction.as_json
    )

    assert_not cached_transaction.save
  end

  test 'should not create a cached transaction without a payload' do
    cached_transaction = CachedTransaction.new(
      cacheable: @transaction,
      request_id: @uuid
    )

    assert_not cached_transaction.save
  end

  test 'should not create a cached transaction with a duplicate request_id' do
    CachedTransaction.create(
      cacheable: @transaction,
      request_id: @uuid,
      payload: @transaction.as_json
    )

    cached_transaction = CachedTransaction.new(
      cacheable: @transaction,
      request_id: @uuid,
      payload: @transaction.as_json
    )

    assert_not cached_transaction.save
  end

  test 'should not update a cached transaction' do
    cached_transaction = cached_transactions(:one)

    assert_raises ActiveRecord::ReadOnlyRecord do
      cached_transaction.update(payload: { amount: 100 })
    end
  end

  test 'should not destroy a cached transaction' do
    cached_transaction = cached_transactions(:one)

    assert_raises ActiveRecord::ReadOnlyRecord do
      cached_transaction.destroy
    end
  end
end
