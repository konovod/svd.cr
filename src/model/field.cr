require "./register_properties"

class SVD::Field
  getter name : String
  getter description : String?
  getter bit_offset : Int32
  getter bit_width : Int32
  getter access : RegisterProperties::Access
  getter enumerated_values : Array(EnumeratedValue)

  def initialize(@name, @description, @bit_offset, @bit_width, @access, @enumerated_values)
  end

  record EnumeratedValue,
    name : String,
    description : String?,
    value : UInt64
end
