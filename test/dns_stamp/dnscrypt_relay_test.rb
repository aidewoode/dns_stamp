require "test_helper"

class DNSStamp::DNSCryptRelayTest < Minitest::Test
  def test_decode
    stamp = DNSStamp::DNSCryptRelay.decode("sdns://gQkxMjcuMC4wLjE")

    assert_equal "DNSCryptRelay", stamp.protocol_name
    assert_equal "127.0.0.1", stamp.address
  end

  def test_decode_ipv6_address
    stamp = DNSStamp::DNSCryptRelay.decode("sdns://gRpbZmU4MDo6NmQ2ZDpmNzJjOjNhZDo2MGI4XQ")

    assert_equal "DNSCryptRelay", stamp.protocol_name
    assert_equal "[fe80::6d6d:f72c:3ad:60b8]", stamp.address
  end
end
