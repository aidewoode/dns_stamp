module DNSStamp
  # DNS-over-HTTPS stamps format:
  #
  # 0x02 || props || LP(addr) || VLP(hash1, hash2, ...hashn) || LP(hostname [:port]) || LP(path) [ || VLP(bootstrap_ip1, bootstrap_ip2, ...bootstrap_ipn) ]
  #
  # addr is the IP address of the server.
  # It can be an empty string. In that case, the host name will be resolved to an IP address using another resolver.
  #
  # hashi is the SHA256 digest of one of the TBS certificate found in the validation chain,
  # typically the certificate used to sign the resolver’s certificate. Multiple hashes can
  # be provided for seamless rotations.
  #
  # hostname is the server host name which will also be used as a SNI name.
  # If the host name contains characters outside the URL-permitted range,
  # these characters should be sent as-is, without any extra encoding (neither URL-encoded nor punycode).
  # The port number is optional, and is assumed to be 443 if missing.
  #
  # path is the absolute URI path, such as /dns-query.
  #
  # bootstrap_ipi are IP addresses of recommended resolvers accessible over standard DNS
  # in order to resolve hostname. This is optional, and clients can ignore this information.
  class DoH < Stamp
    PROTOCOL_ID = 0x02

    attr_accessor :props, :address, :hashes, :host_name, :path, :bootstrap_ips

    def initialize(props: {}, address: "", hashes: [], host_name: "", path: "", bootstrap_ips: [])
      @props = Props.new(**props)
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
