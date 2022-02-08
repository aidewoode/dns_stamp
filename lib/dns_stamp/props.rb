module DNSStamp
  class Props
    DNSSEC = 1
    NO_LOG = 2
    NO_FILTER = 4

    attr_accessor :dnssec, :no_log, :no_filter

    alias_method :dnssec?, :dnssec
    alias_method :no_log?, :no_log
    alias_method :no_filter?, :no_filter

    def initialize(bytes)
      props = bytes.unpack1("Q<")

      @dnssec = props & DNSSEC != 0
      @no_log = props & NO_LOG != 0
      @no_filter = props & NO_FILTER != 0
    end
  end
end
