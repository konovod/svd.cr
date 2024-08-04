require "ecr"
require "compiler/crystal/tools/formatter"
require "./model/*"

module SVD
  def self.render_peripheral(peripheral : SVD::Peripheral, device : SVD::Device, io : IO)
    source = ECR.render("#{__DIR__}/peripheral.ecr")
    io << Crystal.format(source)
  end

  protected def self.larger_int_type(width : Int32) : String
    case width
    when 1       then "Bool"
    when 2..8    then "UInt8"
    when 9..16   then "UInt16"
    when 17..32  then "UInt32"
    when 33..64  then "UInt64"
    when 65..128 then "UInt128"
    else              raise "Unsupported int width: #{width}"
    end
  end
end
