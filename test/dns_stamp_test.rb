require "test_helper"

class DNSStampTest < Minitest::Test
  def test_decode_invalid_prefix_stamp
    assert_raises(DNSStamp::DNSStampArgumentError) do
      DNSStamp.decode("dns://AgcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29tCi9kbnMtcXVlcnk")
    end
  end

  def test_decode_invalide_base64_encode_stamp
    assert_raises(ArgumentError) do
      DNSStamp.decode("sdns://AgcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29tCi9kbnMtcXVl\ncnk=\n")
    end
  end

  def test_decode_invalide_protocol_stamp
    assert_raises(DNSStamp::DNSStampInvalidProtocolError) do
      DNSStamp.decode("sdns://BgcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29tCi9kbnMtcXVlcnk=")
    end
  end

  def test_decode_return_correct_instance
    assert_instance_of DNSStamp::DNSCrypt, DNSStamp.decode("sdns://AQcAAAAAAAAACTEyNy4wLjAuMSDLatxcKflVEAtlvxKU_laEV5qzSZzJeY8A0Bu1wamixxsyLmRuc2NyeXB0LWNlcnQuZXhhbXBsZS5jb20")
    assert_instance_of DNSStamp::DoH, DNSStamp.decode("sdns://AgcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29tCi9kbnMtcXVlcnk")
    assert_instance_of DNSStamp::DoT, DNSStamp.decode("sdns://AwcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29t")
    assert_instance_of DNSStamp::DoQ, DNSStamp.decode("sdns://BAcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29t")
    assert_instance_of DNSStamp::ODoHTarget, DNSStamp.decode("sdns://BQcAAAAAAAAAD2Rucy5leGFtcGxlLmNvbQovZG5zLXF1ZXJ5")
    assert_instance_of DNSStamp::DNSCryptRelay, DNSStamp.decode("sdns://gQkxMjcuMC4wLjE")
    assert_instance_of DNSStamp::ODoHRelay, DNSStamp.decode("sdns://hQcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29tCi9kbnMtcXVlcnk")
    assert_instance_of DNSStamp::PlainDNS, DNSStamp.decode("sdns://AAcAAAAAAAAACTEyNy4wLjAuMQ")
  end
end
