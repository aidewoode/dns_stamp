require "test_helper"

class DNSStamp::DNSCryptTest < Minitest::Test
  def test_decode
    stamp = DNSStamp::DNSCrypt.decode("sdns://AQMAAAAAAAAACTEyNy4wLjAuMSBnyEe4yHWM0SAkVUO-dWdG3zTfHYTAC4xHA2jfgh2GPhsyLmRuc2NyeXB0LWNlcnQuZXhhbXBsZS5jb20")

    assert_equal "DNSCrypt", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert stamp.props.no_log?
    assert_equal "127.0.0.1", stamp.address
    assert_equal "67c847b8c8758cd120245543be756746df34df1d84c00b8c470368df821d863e", stamp.public_key
    assert_equal "2.dnscrypt-cert.example.com", stamp.provider_name
  end

  def test_decode_ipv6_address
    stamp = DNSStamp::DNSCrypt.decode("sdns://AQMAAAAAAAAAGltmZTgwOjo2ZDZkOmY3MmM6M2FkOjYwYjhdIGfIR7jIdYzRICRVQ751Z0bfNN8dhMALjEcDaN-CHYY-GzIuZG5zY3J5cHQtY2VydC5leGFtcGxlLmNvbQ")

    assert_equal "DNSCrypt", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert stamp.props.no_log?
    assert_equal "[fe80::6d6d:f72c:3ad:60b8]", stamp.address
    assert_equal "67c847b8c8758cd120245543be756746df34df1d84c00b8c470368df821d863e", stamp.public_key
    assert_equal "2.dnscrypt-cert.example.com", stamp.provider_name
  end
end
