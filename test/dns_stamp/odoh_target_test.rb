require "test_helper"

class DNSStamp::ODoHTargetTest < Minitest::Test
  def test_decode
    stamp = DNSStamp::ODoHTarget.decode("sdns://BQEAAAAAAAAAFmRvaC10YXJnZXQuZXhhbXBsZS5jb20KL2Rucy1xdWVyeQ")

    assert_equal "ODoHTarget", stamp.protocol_name
    assert stamp.props.dnssec?
    assert !stamp.props.no_filter?
    assert !stamp.props.no_log?
    assert_equal "doh-target.example.com", stamp.host_name
    assert_equal "/dns-query", stamp.path
  end
end
