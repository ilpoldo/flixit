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
      client = HTTPClient.new()
      Flixit::Response.new(client.post("https://flixcloud.com/#{path}", body, 'content_type' => 'application/xml', 
                                                                              'accept' => 'application/xml'))
    rescue HTTPClient::KeepAliveDisconnected
      raise Flixit::ServerBrokeConnection, $!.message
    rescue HTTPClient::ReceiveTimeoutError
      raise Flixit::RequestTimeout, $!.message
    rescue HTTPClient::ConnectTimeoutError
      raise Flixit::ConnectionRefused, $!.message
    end
  end

end
