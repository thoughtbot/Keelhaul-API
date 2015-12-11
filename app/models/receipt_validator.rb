require "faraday_middleware"

class ReceiptValidator
  def initialize(payload:, user:, sandbox: 0)
    @payload = payload
    @user = user
    @sandbox = sandbox
  end

  def validate
    if new_receipt?
      response = post
      create_receipt

      validation_object_for(response.body)
    else
      if token_matches?
        SuccessfulRequest.new
      else
        UnauthenticatedError.new
      end
    end
  end

  private

  attr_reader :payload, :user, :sandbox

  def post
    connection.post do |request|
      request.headers["Content-Type"] = "application/json"
      request.body = payload[:data]
    end
  end

  def connection
    Faraday.new(apple_url) do |faraday|
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end

  def apple_url
    AppleReceipt.endpoint_url(sandbox: sandbox)
  end

  def new_receipt?
    !matching_receipt
  end

  def token_matches?
    matching_receipt.token == payload[:token]
  end

  def matching_receipt
    @_matching_receipt ||= user.receipts.find_by(data: payload[:data])
  end

  def create_receipt
    user.receipts.create(payload)
  end

  def validation_object_for(json)
    case json["status"]
    when 0
      SuccessfulRequest.new
    when 21_003
      UnauthenticatedError.new
    else
      BadRequestError.new
    end
  end

  class SuccessfulRequest
    def http_status
      200
    end

    def valid?
      true
    end
  end

  class UnauthenticatedError
    def http_status
      403
    end

    def valid?
      false
    end
  end

  class BadRequestError
    def http_status
      400
    end

    def valid?
      false
    end
  end
end
