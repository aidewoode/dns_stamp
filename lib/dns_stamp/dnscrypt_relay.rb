module DNSStamp
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
