require "./register_properties"
require "./register"

class SVD::Peripheral
  getter name : String
  getter version : String?
  getter description : String?

  getter base_address : UInt64
  getter register_properties : RegisterProperties::Partial
  getter registers : Array(Register)

  def initialize(@name, @version, @description, @base_address, @register_properties, @registers)
  end
end
