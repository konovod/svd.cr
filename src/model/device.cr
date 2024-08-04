require "./register_properties"
require "./peripheral"

class SVD::Device
  getter schema_version : Float64

  getter licence_text : String?

  getter register_properties : RegisterProperties::Partial

  getter peripherals : Array(Peripheral)

  def initialize(@schema_version, @licence_text, @register_properties, @peripherals)
  end
end
