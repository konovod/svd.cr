module SVD
  record Dim,
    size : Int32,               # dim
    address_increment : UInt64, # dimIncrement
    impl_name : String? do      # dimName
    def impl_name(name : String) : String
      if impl_name = self.impl_name
        return impl_name
      end

      name.gsub("%s", "").delete("[]")
    end

    def instance_name(name : String, index : Int32) : String
      raise "Invalid index" unless 0 <= index < size

      if name.ends_with? "[%s]"
        name[0...-4] + "_#{index}"
      else
        raise "Unsupported dim array usage"
      end
    end

    def instance_addr(base_addr : UInt64, index : Int32) : UInt64
      raise "Invalid index" unless 0 <= index < size

      base_addr + (index * address_increment)
    end
  end
end
