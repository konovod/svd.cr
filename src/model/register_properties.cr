module SVD
  record RegisterProperties,
    size : UInt64,
    protection : Protection?,
    reset_value : UInt64,
    reset_mask : UInt64? do
    enum Access
      ReadOnly
      WriteOnly
      ReadWrite
      WriteOnce
      ReadWriteOnce

      def readable?
        {ReadOnly, ReadWrite, ReadWriteOnce}.includes? self
      end

      def writable?
        {WriteOnly, ReadWrite, WriteOnce, ReadWriteOnce}.includes? self
      end
    end

    enum Protection
      Secure
      NonSecure
      Privileged

      def self.parse(string : String) : self
        case string
        when "s" then Secure
        when "n" then NonSecure
        when "p" then Privileged
        else          super(string)
        end
      end
    end

    record Partial,
      size : UInt64? = nil,
      access : Access? = nil,
      protection : Protection? = nil,
      reset_value : UInt64? = nil,
      reset_mask : UInt64? = nil do
      def to_register_properties : RegisterProperties
        RegisterProperties.new(
          size: size.not_nil!,
          protection: protection,
          reset_value: reset_value.not_nil!,
          reset_mask: reset_mask,
        )
      end
    end
  end
end
