module DNSStamp
  class PlainDNS < Stamp
    PROTOCOL_ID = 0x00

    attr_accessor :props, :address

    def initialize(props: {}, address: "")
      @props = Props.new(props)
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
