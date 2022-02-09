module DNSStamp
  class DNSCrypt < Stamp
    PROTOCOL_ID = 0x01

    attr_accessor :props, :address, :public_key, :provider_name

    def initialize(props: {}, address: "", public_key: "", provider_name: "")
      @props = Props.new(props)
      @address = address
      @public_key = public_key
      @provider_name = provider_name
    end

    class << self
      private

      def parse_attributes
        {
          props: @reader.props,
          address: @reader.lp,
          public_key: @reader.lp_raw,
          provider_name: @reader.lp
        }
      end
    end
  end
end
