require "test_helper"

class DNSStamp::DoQTest < Minitest::Test
  def test_decode
    stamp = DNSStamp::DoQ.decode("sdns://BAMAAAAAAAAACTEyNy4wLjAuMSAqFfXWrLbnwJAa3k67x0OyzNSJAytG4WQvBpNoMAElig9kb3EuZXhhbXBsZS5jb20")

    assert_equal "DoQ", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
    assert_equal ["2a15f5d6acb6e7c0901ade4ebbc743b2ccd489032b46e1642f0693683001258a"], stamp.hashes
    assert_equal "doq.example.com", stamp.host_name
    assert_equal [], stamp.bootstrap_ips
  end

  def test_decode_ipv6_address
    stamp = DNSStamp::DoQ.decode("sdns://BAMAAAAAAAAAGltmZTgwOjo2ZDZkOmY3MmM6M2FkOjYwYjhdICoV9dastufAkBreTrvHQ7LM1IkDK0bhZC8Gk2gwASWKD2RvcS5leGFtcGxlLmNvbQ")

    assert_equal "DoQ", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert stamp.props.no_log?
    assert_equal "[fe80::6d6d:f72c:3ad:60b8]", stamp.address
    assert_equal ["2a15f5d6acb6e7c0901ade4ebbc743b2ccd489032b46e1642f0693683001258a"], stamp.hashes
    assert_equal "doq.example.com", stamp.host_name
    assert_equal [], stamp.bootstrap_ips
  end

  def test_decode_multiple_hashes
    stamp = DNSStamp::DoQ.decode("sdns://BAMAAAAAAAAACTEyNy4wLjAuMaAqFfXWrLbnwJAa3k67x0OyzNSJAytG4WQvBpNoMAEliiCaOjT3J965vKUQA9nOnDn48n3ZxSQpAcK6saROY1oCGQ9kb3EuZXhhbXBsZS5jb20")

    assert_equal "DoQ", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
    assert_equal ["2a15f5d6acb6e7c0901ade4ebbc743b2ccd489032b46e1642f0693683001258a", "9a3a34f727deb9bca51003d9ce9c39f8f27dd9c5242901c2bab1a44e635a0219"], stamp.hashes
    assert_equal "doq.example.com", stamp.host_name
    assert_equal [], stamp.bootstrap_ips
  end

  def test_decode_with_bootstrap_ips
    stamp = DNSStamp::DoQ.decode("sdns://BAAAAAAAAAAACTEyNy4wLjAuMSA-GhoPbFPz6XpJLVcIS1uYBwWe4FerFQWHb9g_2j24OA9kb3EuZXhhbXBsZS5jb20HMS4xLjEuMQ")

    assert_equal "DoQ", stamp.protocol_name
    assert !stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
    assert_equal ["3e1a1a0f6c53f3e97a492d57084b5b9807059ee057ab1505876fd83fda3db838"], stamp.hashes
    assert_equal "doq.example.com", stamp.host_name
    assert_equal ["1.1.1.1"], stamp.bootstrap_ips
  end
end
