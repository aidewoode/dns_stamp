module DNSStamp
  class ODoHTarget < Stamp
    PROTOCOL_ID = 0x05

    attr_accessor :props, :host_name, :path

    def initialize(props: {}, host_name: "", path: "")
      @props = Props.new(props)
      @host_name = host_name
      @path = path
    end

    class << self
      private

      def parse_attributes
        {
          props: @reader.props,
          host_name: @reader.lp,
          path: @reader.lp
        }
      end
    end
  end
end
