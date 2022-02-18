require "test_helper"

class DNSStamp::StampTest < Minitest::Test
  class SubStamp < DNSStamp::Stamp
    PROTOCOL_ID = 0x00
  end

  class SubStampWithParse < DNSStamp::Stamp
    PROTOCOL_ID = 0x00

    def initialize(_attributes)
    end

    def self.parse_attributes
      {}
    end
  end

  def test_sub_class_not_implemented_parse_attributes_method
    assert_raises(NotImplementedError) do
      SubStamp.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ")
    end
  end

  def test_decode_invalid_prefix_stamp
    assert_raises(DNSStamp::DNSStampArgumentError) do
      SubStampWithParse.decode("dns://AAEAAAAAAAAACTEyNy4wLjAuMQ")
    end
  end

  def test_decode_invalide_base64_encode_stamp
    assert_raises(ArgumentError) do
      SubStampWithParse.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ==\n")
    end
  end

  def test_decode_invalide_protocol_stamp
    assert_raises(DNSStamp::DNSStampInvalidProtocolError) do
      SubStampWithParse.decode("sdns://AwcAAAAAAAAACTEyNy4wLjAuMQAPZG5zLmV4YW1wbGUuY29t")
    end
  end

  def test_protocol_name
    stamp = SubStampWithParse.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ")
    assert_equal "SubStampWithParse", stamp.protocol_name
  end

  def test_parse_auto_close_data
    data = StringIO.new("\x01\x00\x00\x00\x00\x00\x00\x00\t127.0.0.1".b)
    SubStampWithParse.send(:parse, data)

    assert data.closed?
  end
end
