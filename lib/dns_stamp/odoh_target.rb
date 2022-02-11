module DNSStamp
  # Oblivious DoH target stamps format:
  #
  # 0x05 || props || LP(hostname [:port]) || LP(path)
  #
  # hostname is the server host name which, for relays, will also be used as a SNI name.
  # If the host name contains characters outside the URL-permitted range,
  # these characters should be sent as-is,
  # without any extra encoding (neither URL-encoded nor punycode).
  #
  # The port number is optional, and is assumed to be 443 if missing.
  #
  # path is the absolute URI path, such as /dns-query.
  class ODoHTarget < Stamp
    PROTOCOL_ID = 0x05

    attr_accessor :props, :host_name, :path

    def initialize(props: {}, host_name: "", path: "")
      @props = Props.new(**props)
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
