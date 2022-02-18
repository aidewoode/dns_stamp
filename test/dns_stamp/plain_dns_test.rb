require "test_helper"

class DNSStamp::PlainDNSTest < Minitest::Test
  def test_decode
    stamp = DNSStamp::PlainDNS.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ")

    assert_equal "PlainDNS", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
  end

  def test_decode_ipv6_address
    stamp = DNSStamp::PlainDNS.decode("sdns://AAMAAAAAAAAAGltmZTgwOjo2ZDZkOmY3MmM6M2FkOjYwYjhd")

    assert_equal "PlainDNS", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert stamp.props.no_log?
    assert_equal "[fe80::6d6d:f72c:3ad:60b8]", stamp.address
  end
end
