require "./register_properties"
require "./register"
require "./cluster"

class SVD::Peripheral
  getter name : String
  getter version : String?
  getter description : String?

  getter base_address : UInt64
  getter register_properties : RegisterProperties::Partial
  getter registers : Array(Register)
  getter clusters : Array(Cluster)

  def initialize(@name, @version, @description, @base_address, @register_properties, @registers, @clusters)
  end
end
