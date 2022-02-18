require "test_helper"

class DNSStamp::ODoHRelayTest < Minitest::Test
  def test_decode
    stamp = DNSStamp::ODoHRelay.decode("sdns://hQEAAAAAAAAACTEyNy4wLjAuMSAqFfXWrLbnwJAa3k67x0OyzNSJAytG4WQvBpNoMAElihVkb2gtcmVsYXkuZXhhbXBsZS5jb20KL2Rucy1xdWVyeQ")

    assert_equal "ODoHRelay", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
    assert_equal ["2a15f5d6acb6e7c0901ade4ebbc743b2ccd489032b46e1642f0693683001258a"], stamp.hashes
    assert_equal "doh-relay.example.com", stamp.host_name
    assert_equal "/dns-query", stamp.path
    assert_equal [], stamp.bootstrap_ips
  end

  def test_decode_ipv6_address
    stamp = DNSStamp::ODoHRelay.decode("sdns://hQEAAAAAAAAAGltmZTgwOjo2ZDZkOmY3MmM6M2FkOjYwYjhdICoV9dastufAkBreTrvHQ7LM1IkDK0bhZC8Gk2gwASWKFWRvaC1yZWxheS5leGFtcGxlLmNvbQovZG5zLXF1ZXJ5")

    assert_equal "ODoHRelay", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "[fe80::6d6d:f72c:3ad:60b8]", stamp.address
    assert_equal ["2a15f5d6acb6e7c0901ade4ebbc743b2ccd489032b46e1642f0693683001258a"], stamp.hashes
    assert_equal "doh-relay.example.com", stamp.host_name
    assert_equal "/dns-query", stamp.path
    assert_equal [], stamp.bootstrap_ips
  end

  def test_decode_multiple_hashes
    stamp = DNSStamp::ODoHRelay.decode("sdns://hQEAAAAAAAAAGltmZTgwOjo2ZDZkOmY3MmM6M2FkOjYwYjhdoCoV9dastufAkBreTrvHQ7LM1IkDK0bhZC8Gk2gwASWKIJo6NPcn3rm8pRAD2c6cOfjyfdnFJCkBwrqxpE5jWgIZFWRvaC1yZWxheS5leGFtcGxlLmNvbQovZG5zLXF1ZXJ5")

    assert_equal "ODoHRelay", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "[fe80::6d6d:f72c:3ad:60b8]", stamp.address
    assert_equal ["2a15f5d6acb6e7c0901ade4ebbc743b2ccd489032b46e1642f0693683001258a", "9a3a34f727deb9bca51003d9ce9c39f8f27dd9c5242901c2bab1a44e635a0219"], stamp.hashes
    assert_equal "doh-relay.example.com", stamp.host_name
    assert_equal "/dns-query", stamp.path
    assert_equal [], stamp.bootstrap_ips
  end

  def test_decode_with_bootstrap_ips
    stamp = DNSStamp::ODoHRelay.decode("sdns://hQAAAAAAAAAACTEyNy4wLjAuMSA-GhoPbFPz6XpJLVcIS1uYBwWe4FerFQWHb9g_2j24OBVkb2gtcmVsYXkuZXhhbXBsZS5jb20KL2Rucy1xdWVyeQcxLjEuMS4x")

    assert_equal "ODoHRelay", stamp.protocol_name
    assert !stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
    assert_equal ["3e1a1a0f6c53f3e97a492d57084b5b9807059ee057ab1505876fd83fda3db838"], stamp.hashes
    assert_equal "doh-relay.example.com", stamp.host_name
    assert_equal "/dns-query", stamp.path
    assert_equal ["1.1.1.1"], stamp.bootstrap_ips
  end
end
