require "test_helper"

class DNSStamp::DecoderTest < Minitest::Test
  class StampWithoutValidateProtocol
    include DNSStamp::Decoder

    def self.parse(data)
    end
  end

  class StampWithoutParse
    include DNSStamp::Decoder

    def self.validate_protocol(byte)
    end
  end

  class Stamp
    include DNSStamp::Decoder

    def self.parse(data)
    end

    def self.validate_protocol(byte)
    end
  end

  def test_not_implemented_validate_protocol
    assert_raises(NotImplementedError) do
      StampWithoutValidateProtocol.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ")
    end
  end

  def test_not_implemented_parse
    assert_raises(NotImplementedError) do
      StampWithoutParse.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ")
    end
  end

  def test_decode_invalid_prefix_stamp
    assert_raises(DNSStamp::DNSStampArgumentError) do
      Stamp.decode("dns://AAEAAAAAAAAACTEyNy4wLjAuMQ")
    end
  end

  def test_decode_invalide_base64_encode_stamp
    assert_raises(ArgumentError) do
      Stamp.decode("sdns://AAEAAAAAAAAACTEyNy4wLjAuMQ==\n")
    end
  end
end
