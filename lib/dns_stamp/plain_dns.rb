module DNSStamp
  # Plain DNS stamps format:
  #
  # 0x00 || props || LP(addr [:port])
  #
  # addr is the IP address of the server.
  # IPv6 strings must be included in square brackets: [fe80::6d6d:f72c:3ad:60b8].
  # Scopes are permitted.
  class PlainDNS < Stamp
    PROTOCOL_ID = 0x00

    attr_accessor :props, :address

    def initialize(props: {}, address: "")
      @props = Props.new(**props)
      @address = address
    end

    class << self
      private

      def parse_attributes
        {
          props: @reader.props,
          address: @reader.lp
        }
      end
    end
  end
end
