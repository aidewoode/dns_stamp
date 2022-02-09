require "base64"
require "stringio"

require "dns_stamp/errors"
require "dns_stamp/version"

require "dns_stamp/decoder"
require "dns_stamp/reader"
require "dns_stamp/props"

require "dns_stamp/stamp"
require "dns_stamp/dnscrypt"
require "dns_stamp/doh"
require "dns_stamp/dot"
require "dns_stamp/doq"
require "dns_stamp/odoh_target"
require "dns_stamp/dnscrypt_relay"
require "dns_stamp/odoh_relay"
require "dns_stamp/plain_dns"

module DNSStamp
  PROTOCOLS = [:DNSCrypt, :DoH, :DoT, :DoQ, :ODoHTarget, :DNSCryptRelay, :ODoHRelay, :PlainDNS].freeze

  PROTOCOLS_MAPPING = PROTOCOLS.map do |protocol|
    [const_get("#{protocol}::PROTOCOL_ID"), const_get(protocol)]
  end.to_h.freeze

  include Decoder

  class << self
    private

    def validate_protocol(protocol_byte)
      @protocol_byte = protocol_byte
      raise DNSStampInvalidProtocolError, "Unsupported protocol" unless PROTOCOLS_MAPPING.key? @protocol_byte
    end

    def parse(data)
      PROTOCOLS_MAPPING[@protocol_byte].send(:parse, data)
    end
  end
end
