require "middleman-emojifire/content"
require "middleman-emojifire/ext/emoji_extension"

module Middleman
  module Emojifire
    class Converter
      attr_reader :content

      using Middleman::Emojifire::EmojiExtension

      def initialize(content)
        @content = ::Middleman::Emojifire::Content.new(content)
      end

      def convert
        if content.include_body?
          content.body_only { |body| emojify(body) }
        else
          emojify(content.to_s)
        end
      end

      private

      def emojify(source)
        source.gsub(/:([\w+-]+):/) do |match|
          if (emoji = Emoji.find_by_alias(Regexp.last_match[1]))
            emoji.raw ? emoji.raw_unicode_character_html : emoji.fallback_image_html
          else
            match
          end
        end
      end
    end
  end
end
