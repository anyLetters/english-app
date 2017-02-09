require 'active_support/concern'

module YandexDictionary
  extend ActiveSupport::Concern

    def translate(word)
      require 'net/https'
      require 'openssl'
      require 'open-uri'
      api_key = Rails.application.secrets.yandex_dict
      uri = URI.parse('https://dictionary.yandex.net/api/v1/dicservice.json/lookup')
      param = { :key => api_key, :lang => 'en-ru', :text => word }
      uri.query = URI.encode_www_form(param)
      http = Net::HTTP.new(uri.host, uri.port, 'Content-Type' => 'application/json')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = Net::HTTP.get(uri)

      return json_response = JSON.parse response
    end
end
