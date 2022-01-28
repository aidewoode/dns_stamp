module DNSStamp
  class DoH < Stamp
    PROTOCOL_ID = 0x02

    class << self
      private

      def validate_protocol
        raise DNSStampInvalidProtocolError, "Stamp is not DoH protocol" unless @protocol_byte == PROTOCOL_ID
      end

      def parse(data)
        "doh"
      end
    end
  end
end
