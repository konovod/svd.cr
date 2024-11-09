require "./register_properties"
require "./field"
require "./dim"

class SVD::Register
  getter name : String
  getter description : String?
  getter address_offset : UInt64
  getter properties : RegisterProperties
  getter access : RegisterProperties::Access?
  getter fields : Array(Field)
  getter dim : Dim?

  def initialize(@name, @description, @address_offset, @properties, @access, @fields, @dim)
  end
end
