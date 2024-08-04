require "./svd"

device = SVD.parse(File.read(ARGV[0]))
device.peripherals.each do |peripheral|
  outfile = "#{File.dirname(ARGV[0])}/#{peripheral.name.underscore}.cr"
  File.open(outfile, "w") do |file|
    SVD.render_peripheral(peripheral, device, file)
  end
end
