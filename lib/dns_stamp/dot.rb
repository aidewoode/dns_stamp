module DNSStamp
  class DoT < Stamp
    PROTOCOL_ID = 0x03

    attr_accessor :props, :address, :hashes, :host_name, :bootstrap_ips

    def initialize(props: {}, address: "", hashes: [], host_name: "", bootstrap_ips: [])
      @props = Props.new(props)
      @address = address
      @hashes = hashes
      @host_name = host_name
      @bootstrap_ips = bootstrap_ips
    end

    class << self
      private

      def parse_attributes
        {
          props: @reader.props,
          address: @reader.lp,
          hashes: @reader.vlp_raw,
          host_name: @reader.lp,
          bootstrap_ips: @reader.vlp
        }
      end
    end
  end
end
