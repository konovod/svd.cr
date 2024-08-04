require "./register_properties"
require "./field"

class SVD::Register
  getter name : String
  getter description : String?
  getter address_offset : UInt64
  getter properties : RegisterProperties
  getter access : RegisterProperties::Access?
  getter fields : Array(Field)

  def initialize(@name, @description, @address_offset, @properties, @access, @fields)
  end
end
