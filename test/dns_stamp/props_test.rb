require "test_helper"

class DNSStamp::PropsTest < Minitest::Test
  def test_decode
    props_value = DNSStamp::Props.decode("\x01\x00\x00\x00\x00\x00\x00\x00")

    assert props_value[:dnssec]
    assert !props_value[:no_log]
    assert !props_value[:no_filter]
  end

  def test_initialize
    props_value = DNSStamp::Props.decode("\x06\x00\x00\x00\x00\x00\x00\x00")
    props = DNSStamp::Props.new(**props_value)

    assert !props.dnssec?
    assert props.no_log?
    assert props.no_filter?
  end
end
