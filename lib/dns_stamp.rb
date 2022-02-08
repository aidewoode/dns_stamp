require "base64"
require "stringio"

require "dns_stamp/errors"
require "dns_stamp/version"

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
  def self.decode(stamp)
    Stamp.decode(stamp)
  end
end
