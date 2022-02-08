module DNSStamp
  class DoH < Stamp
    PROTOCOL_ID = 0x02

    attr_accessor :props, :address, :hashes, :host_name, :path, :bootstrap_ips

    class << self
      private

      def validate_protocol
        raise DNSStampInvalidProtocolError, "Stamp is not DoH protocol" unless @@protocol_byte == PROTOCOL_ID
      end

      def parse
        doh = DoH.new
        doh.props = reader.props
        doh.address = reader.lp
        doh.hashes = reader.vlp_raw
        doh.host_name = reader.lp
        doh.path = reader.lp
        doh.bootstrap_ips = reader.vlp

        doh
      end
    end
  end
end
