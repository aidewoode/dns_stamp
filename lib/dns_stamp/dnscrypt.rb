module DNSStamp
  # DNSCrypt Stamps format:
  #
  # 0x01 || props || LP(addr [:port]) || LP(pk) || LP(providerName)
  #
  # 0x01 is the protocol identifier for DNSCrypt.
  #
  # addr is the IP address, as a string, with a port number if the server is not accessible over the standard port for the protocol (443).
  # IPv6 strings must be included in square brackets: [fe80::6d6d:f72c:3ad:60b8]. Scopes are permitted.
  #
  # pk is the DNSCrypt provider’s Ed25519 public key, as 32 raw bytes.
  #
  # providerName is the DNSCrypt provider name.
  class DNSCrypt < Stamp
    PROTOCOL_ID = 0x01

    attr_accessor :props, :address, :public_key, :provider_name

    def initialize(props: {}, address: "", public_key: "", provider_name: "")
      @props = Props.new(**props)
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
