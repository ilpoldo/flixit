class Flixit::Response

  attr_accessor :code, :body, :errors, :body_as_hash

  def initialize(response)
    self.body = response.content
    case self.code = response.code
    when 401 then raise Flixit::AuthenticationError
    else  
      self.body_as_hash = Crack::XML.parse(response.content)
      self.errors = []
      process_response_xml
    end
  end

  def success?
    201 == code.to_i
  end


protected

  def process_response_xml
    if body_as_hash['errors'] && body_as_hash['errors'].is_a?(Hash) && body_as_hash['errors']['error']
      self.errors = Array(body_as_hash['errors']['error'])
    end
  end

end
