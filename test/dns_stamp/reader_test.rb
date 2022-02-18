require "test_helper"

class DNSStamp::ReaderTest < Minitest::Test
  def test_read_data
    data = StringIO.new("\x03\x00\x00\x00\x00\x00\x00\x00\t127.0.0.1 g\xC8G\xB8\xC8u\x8C\xD1 $UC\xBEugF\xDF4\xDF\x1D\x84\xC0\v\x8CG\x03h\xDF\x82\x1D\x86> >\x1A\x1A\x0FlS\xF3\xE9zI-W\bK[\x98\a\x05\x9E\xE0W\xAB\x15\x05\x87o\xD8?\xDA=\xB88\a1.1.1.1".b)
    reader = DNSStamp::Reader.new(data)
    props = reader.props

    assert props[:dnssec]
    assert !props[:no_filter]
    assert props[:no_log]
    assert_equal "127.0.0.1", reader.lp
    assert_equal "67c847b8c8758cd120245543be756746df34df1d84c00b8c470368df821d863e", reader.lp_hex
    assert_equal ["3e1a1a0f6c53f3e97a492d57084b5b9807059ee057ab1505876fd83fda3db838"], reader.vlp_hex
    assert_equal ["1.1.1.1"], reader.vlp
  end
end
