module DNSStamp
  # Props is a little-endian 64 bit value that represents informal properties about the resolver.
  # It is a logical OR combination of the following values:
  #
  # 1: the server supports DNSSEC
  # 2: the server doesn’t keep logs
  # 4: the server doesn’t intentionally block domains
  class Props
    DNSSEC = 1
    NO_LOG = 2
    NO_FILTER = 4

    attr_accessor :dnssec, :no_log, :no_filter

    alias_method :dnssec?, :dnssec
    alias_method :no_log?, :no_log
    alias_method :no_filter?, :no_filter

    def initialize(dnssec: false, no_log: false, no_filter: false)
      @dnssec = dnssec
      @no_log = no_log
      @no_filter = no_filter
    end

    def self.decode(bytes)
      props = bytes.unpack1("Q<")

      {
        dnssec: props & DNSSEC != 0,
        no_log: props & NO_LOG != 0,
        no_filter: props & NO_FILTER != 0
      }
    end
  end
end
