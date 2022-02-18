module DNSStamp
  # len(x) is a single byte representation of the length of x, in bytes.
  # Strings don’t have to be zero-terminated and do not require invidual encoding.
  #
  # vlen(x) is equal to len(x) if x is the last element of a set, and 0x80 | len(x) if there are more elements in the set.
  #
  # LP(x) is len(x) || x, i.e x prefixed by its length.
  #
  # VLP(x1, x2, ...xn) encodes a set, as vlen(x1) || x1 || vlen(x2) || x2 ... || vlen(xn) || xn.
  # Since vlen(xn) == len(xn) (length of the last element doesn’t have the high bit set),
  # for a set with a single element, we have VLP(x) == LP(x).
  class Reader
    VLEN_PREFIX = 0x80

    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def props
      Props.decode(data.read(8))
    end

    def lp_hex
      lp_raw.unpack1("H*")
    end

    def lp
      lp_raw.force_encoding("utf-8")
    end

    def vlp_hex
      vlp_raw.map { |data| data.unpack1("H*") }
    end

    def vlp
      vlp_raw.map { |data| data.force_encoding("utf-8") }
    end

    private

    def lp_raw
      length = data.getbyte
      data.read(length)
    end

    def vlp_raw
      vlp_data = []

      loop do
        prefix_byte = data.getbyte
        break if prefix_byte.nil?

        length = prefix_byte & ~VLEN_PREFIX
        vlp_data.push(data.read(length))

        break if prefix_byte & VLEN_PREFIX != VLEN_PREFIX
      end

      vlp_data
    end
  end
end
