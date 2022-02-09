module DNSStamp
  class ODoHRelay < Stamp
    PROTOCOL_ID = 0x85

    attr_accessor :props, :address, :hashes, :host_name, :path, :bootstrap_ips

    def initialize(props: {}, address: "", hashes: [], host_name: "", path: "", bootstrap_ips: [])
      @props = Props.new(props)
      @address = address
      @hashes = hashes
      @host_name = host_name
      @path = path
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
          path: @reader.lp,
          bootstrap_ips: @reader.vlp
        }
      end
    end
  end
end
