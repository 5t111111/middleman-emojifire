module Middleman
  module Emojifire
    class Content
      attr_reader :source

      def initialize(source)
        @source = source.to_s
      end

      def include_body?
        source =~ %r{<body.*?>.*?</body>}m ? true : false
      end

      def body_only
        source.gsub(%r{<body.*?>(.*?)</body>}m) do |match|
          yield match
        end
      end

      def to_s
        source
      end
    end
  end
end
