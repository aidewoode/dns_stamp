module DNSStamp
  class Reader
    VLEN_PREFIX = 0x80

    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def props
      Props.new(data.read(8))
    end

    def lp_raw
      length = data.getbyte
      data.read(length)
    end

    def lp
      lp_raw.force_encoding("utf-8")
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

    def vlp
      return vlp_raw if vlp_raw.empty?

      vlp_raw.map { |data| data.force_encoding("utf-8") }
    end
  end
end
