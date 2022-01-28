module DNSStamp
  class Stamp
    PREFIX = "sdns://"

    PROTOCOLS = [:DNSCrypt, :DoH, :DoT, :DoQ, :ODoHTarget, :DNSCryptRelay, :ODoHRelay, :PlainDNS].freeze

    def self.decode(stamp)
      stamp_string = stamp.to_str
      raise DNSStampArgumentError, "Invalid prefix" unless stamp_string.delete_prefix! PREFIX

      stamp_data = StringIO.new(Base64.urlsafe_decode64(stamp_string))
      @protocol_byte = stamp_data.getbyte

      validate_protocol
      parse(stamp_data)
    ensure
      stamp_data.close
    end

    class << self
      private

      def protocols_mapping
        @protocols_mapping ||= PROTOCOLS.map do |protocol|
          [const_get("DNSStamp::#{protocol}::PROTOCOL_ID"), const_get("DNSStamp::#{protocol}")]
        end.to_h.freeze
      end

      def validate_protocol
        raise DNSStampInvalidProtocolError, "Unsupported protocol" unless protocols_mapping.key? @protocol_byte
      end

      def parse(data)
        protocols_mapping[@protocol_byte].send(:parse, data)
      end
    end
  end
end
