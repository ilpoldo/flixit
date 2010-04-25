class Flixit::Error < StandardError; end
class Flixit::SaveError < Flixit::Error; end
class Flixit::CreateError < Flixit::Error; end
class Flixit::ServerBrokeConnection < Flixit::Error; end
class Flixit::RequestTimeout < Flixit::Error; end
class Flixit::ConnectionRefused < Flixit::Error; end
