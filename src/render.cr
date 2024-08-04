require "ecr"
require "compiler/crystal/tools/formatter"
require "./model/*"

module SVD
  def self.render_peripheral(peripheral : SVD::Peripheral, device : SVD::Device, io : IO)
    source = ECR.render("#{__DIR__}/peripheral.ecr")
    io << Crystal.format(source)
  end

  protected def self.larger_uint(width : Int) : Int.class
    case width
    when 1..8    then UInt8
    when 9..16   then UInt16
    when 17..32  then UInt32
    when 33..64  then UInt64
    when 65..128 then UInt128
    else              raise "Unsupported int width: #{width}"
    end
  end

  protected def self.hex(int : Int) : String
    suffix = case int
             when UInt8   then "_u8"
             when Int8    then "_i8"
             when UInt16  then "_u16"
             when Int16   then "_i16"
             when UInt32  then "_u32"
             when Int32   then "_i32"
             when UInt64  then "_u64"
             when Int64   then "_i64"
             when UInt128 then "_u128"
             when Int128  then "_i128"
             end
    "0x#{int.to_s(16)}#{suffix}"
  end
end
