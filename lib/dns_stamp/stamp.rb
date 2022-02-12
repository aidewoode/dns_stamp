module DNSStamp
  class Stamp
    include Decoder

    def protocol_name
      self.class.send(:protocol_name)
    end

    class << self
      private

      def protocol_name
        name.split("::").last
      end

      def validate_protocol(protocol_byte)
        raise DNSStampInvalidProtocolError, "Stamp is not #{protocol_name} protocol" unless protocol_byte == self::PROTOCOL_ID
      end

      def parse(data)
        @reader = Reader.new(data)
        attributes = parse_attributes

        new(**attributes)
      end

      def parse_attributes
        raise NotImplementedError
      end
    end
  end
end
