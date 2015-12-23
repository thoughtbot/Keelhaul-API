module Response
  def self.for(json)
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
