# Manages all transaction related operations
class TransactionService
  attr_reader :request_id, :transaction

  def initialize(params, request_id:)
    @params = params
    @request_id = request_id
  end

  def create(using_cache: true)
    return @transaction if using_cache && cached?

    create_transaction(using_cache:)
  end

  delegate :errors, to: :transaction

  private

  def cached?
    @cached_response = CachedTransaction.find_by(request_id: @params[:request_id])
    return false if @cached_response.blank?

    @transaction = @cached_response.cacheable
    true
  end

  def cache_response(transaction:)
    CachedTransaction.create(cacheable: transaction, request_id:, payload: transaction.as_json)
  end

  def create_transaction(using_cache: true)
    @transaction = Transaction.new(@params)
    cache_response(transaction:) if @transaction.save && using_cache

    @transaction
  end
end
