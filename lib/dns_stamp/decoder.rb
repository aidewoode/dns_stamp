module DNSStamp
  module Decoder
    STAMP_PREFIX = "sdns://"

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def decode(stamp)
        stamp_string = stamp.to_str

        # DNS Stamp start with 'sdns://'
        raise DNSStampArgumentError, "Invalid prefix" unless stamp_string.delete_prefix! STAMP_PREFIX

        # DNS Stamp encode with URL-safe base64 encoding
        stamp_data = StringIO.new(Base64.urlsafe_decode64(stamp_string))
        protocol_byte = stamp_data.getbyte

        validate_protocol(protocol_byte)
        parse(stamp_data)
      end

      private

      def validate_protocol(protocol_byte)
        raise NotImplementedError
      end

      def parse(data)
        raise NotImplementedError
      end
    end
  end
end
