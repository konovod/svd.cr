module SVD::Transform::RedundantNaming
  extend self

  def transform(device : Device) : Device
    Device.new(
      schema_version: device.schema_version,
      licence_text: device.licence_text,
      register_properties: device.register_properties,
      peripherals: device.peripherals.map { |p| transform(p) },
    )
  end

  def transform(peripheral : Peripheral) : Peripheral
    names = Set{peripheral.name}

    Peripheral.new(
      name: peripheral.name,
      version: peripheral.version,
      description: peripheral.description,
      base_address: peripheral.base_address,
      register_properties: peripheral.register_properties,
      registers: peripheral.registers.map { |r| transform(r, names) },
      clusters: peripheral.clusters.map { |c| transform(c, names) },
    )
  end

  def transform(cluster : Cluster, names : Set(String)) : Cluster
    new_names = names + Set{cluster.name}

    Cluster.new(
      name: transform(cluster.name, names),
      description: cluster.description,
      address_offset: cluster.address_offset,
      register_properties: cluster.register_properties,
      registers: cluster.registers.map { |r| transform(r, new_names) },
      dim: cluster.dim,
    )
  end

  def transform(register : Register, names : Set(String)) : Register
    new_names = names + Set{register.name}

    Register.new(
      name: transform(register.name, names),
      description: register.description,
      address_offset: register.address_offset,
      properties: register.properties,
      access: register.access,
      fields: register.fields.map { |f| transform(f, new_names) },
      dim: register.dim,
    )
  end

  def transform(field : Field, names : Set(String)) : Field
    new_names = names + Set{field.name}

    Field.new(
      name: transform(field.name, names),
      description: field.description,
      bit_offset: field.bit_offset,
      bit_width: field.bit_width,
      access: field.access,
      enumerated_values: field.enumerated_values.map { |ev| transform(ev, new_names) },
    )
  end

  def transform(ev : Field::EnumeratedValue, names : Set(String)) : Field::EnumeratedValue
    ev.copy_with(name: transform(ev.name, names))
  end

  def transform(name : String, context_names : Set(String)) : String
    old_name = nil
    until name == old_name
      old_name = name

      context_names.each do |context|
        prospective_name = name.lchop(context).lstrip("-_ ")

        unless prospective_name.empty?
          name = prospective_name
        end
      end
    end

    name
  end
end
