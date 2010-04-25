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
      Flixit::Response.new(HTTPClient::Resource.new("https://flixcloud.com/#{path}",
                                                       :verify_ssl => OpenSSL::SSL::VERIFY_PEER).post(body, :content_type => 'application/xml', :accept => 'application/xml'))
    rescue HTTPClient::ServerBrokeConnection
      raise Flixit::ServerBrokeConnection, $!.message
    rescue HTTPClient::RequestTimeout
      raise Flixit::RequestTimeout, $!.message
    rescue HTTPClient::ConnectionRefused
      raise Flixit::ConnectionRefused, $!.message
    end
  end

end
