require "base64"
require "stringio"

require "dns_stamp/errors"
require "dns_stamp/version"

require "dns_stamp/stamp"
require "dns_stamp/dnscrypt_stamp"
require "dns_stamp/doh_stamp"
require "dns_stamp/dot_stamp"
require "dns_stamp/doq_stamp"
require "dns_stamp/odoh_target_stamp"
require "dns_stamp/dnscrypt_relay_stamp"
require "dns_stamp/odoh_relay_stamp"
require "dns_stamp/plain_dns_stamp"

module DNSStamp
  STAMP_PREFIX = "sdns://"

  STAMP_PROTOCOLS_MAPPING = {
    0x01 => :DNSCryptStamp,
    0x02 => :DoHStamp,
    0x03 => :DoTStamp,
    0x04 => :DoQStamp,
    0x05 => :ODoHTargetStamp,
    0x81 => :DNSCryptRelayStamp,
    0x85 => :ODoHRelayStamp,
    0x00 => :PlainDNSStamp
  }.freeze

  def self.decode(stamp)
    stamp_string = stamp.to_str
    raise DNSStampArgumentError, "Invalid prefix" unless stamp_string.delete_prefix! STAMP_PREFIX

    stamp_data = StringIO.new(Base64.urlsafe_decode64(stamp_string))
    protocol_byte = stamp_data.getbyte
    raise DNSStampArgumentError, "Unsupported protocol" unless STAMP_PROTOCOLS_MAPPING.key? protocol_byte

    const_get(STAMP_PROTOCOLS_MAPPING[protocol_byte]).new(stamp_data)
  end
end
