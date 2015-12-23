module Response
  def self.for(json)
    case json["status"]
    when 0
      metadata = json.fetch("receipt").
        slice(*Receipt::APPLE_METADATA_KEY_WHITELIST)
      SuccessfulRequest.new(metadata)
    when 21_003
      UnauthenticatedError.new
    else
      BadRequestError.new
    end
  end

  class SuccessfulRequest
    def initialize(json)
      @json = json
    end

    def http_status
      200
    end

    def on_success
      yield
      self
    end

    def as_json(*)
      @json
    end
  end

  class UnauthenticatedError
    def http_status
      403
    end

    def on_success
      self
    end
  end

  class BadRequestError
    def http_status
      400
    end

    def on_success
      self
    end
  end
end
