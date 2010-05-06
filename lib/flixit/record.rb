class Flixit::Record

  attr_accessor :errors

  def initialize(attrs={})
    self.errors = []
    self.attributes = attrs
  end

  def attributes=(attrs)
    attrs.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end

  def self.record_column(attribute, klass)
    eval %{
      attr_reader :#{attribute}

      def #{attribute}=(value)
        if @#{attribute}
          @#{attribute}.attributes = value
        else
          @#{attribute} = Flixit::#{klass}.new(value)
        end
      end
    }
  end


protected

  def post(path, body)
    begin
      flixcloud = RestClient::Resource.new(
        "https://www.flixcloud.com/#{path}",
        # :ssl_client_cert  =>  OpenSSL::X509::Certificate.new(File.read("host.cert")),
        # :ssl_client_key   =>  OpenSSL::PKey::RSA.new(File.read("host.key"), ""),
        # :ssl_ca_file => Flixit::CA_FILE,
        # :verify_ssl => OpenSSL::SSL::VERIFY_PEER
        :verify_ssl => false
      )
      Flixit::Response.new(flixcloud.post(body, :content_type => 'application/xml', :accept => 'text/xml') do |response, &block|
        if [301, 302, 303].include? response.code
          response.follow_redirection &block
        else
          response.return! &block
        end
      end)
      # flixcloud.post  body |response, &block|
      #    if [301, 302].include? response.code
      #      response.follow_redirection &block
      #    else
      #      response.return! &block
      #    end
      #  }
      # rescue HTTPClient::KeepAliveDisconnected
      #   raise Flixit::ServerBrokeConnection, $!.message
      # rescue HTTPClient::ReceiveTimeoutError
      #   raise Flixit::RequestTimeout, $!.message
      # rescue HTTPClient::ConnectTimeoutError
      #   raise Flixit::ConnectionRefused, $!.message
    end
  end

end
