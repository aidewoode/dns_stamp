module DNSStamp
  # Anonymized DNSCrypt relay stamps format:
  #
  # 0x81 || LP(addr)
  #
  # 0x81 is the protocol identifier for a DNSCrypt relay.
  #
  # addr is the IP address and port, as a string.
  # IPv6 strings must be included in square brackets: [fe80::6d6d:f72c:3ad:60b8]:443.
  class DNSCryptRelay < Stamp
    PROTOCOL_ID = 0x81

    attr_accessor :address

    def initialize(address: "")
      @address = address
    end

    class << self
      private

      def parse_attributes
        {address: @reader.lp}
      end
    end
  end
end
