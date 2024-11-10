require "./register_properties"
require "./register"
require "./dim"

class SVD::Cluster
  getter name : String
  getter description : String?

  getter address_offset : UInt64
  getter register_properties : RegisterProperties::Partial
  getter registers : Array(Register)
  getter dim : Dim?

  def initialize(@name, @description, @address_offset, @register_properties, @registers, @dim)
  end
end
