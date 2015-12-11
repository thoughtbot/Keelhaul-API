module ApiHelpers
  def authenticate_with_token(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :request
end
