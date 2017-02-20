require "gemoji"

module Middleman
  module Emojifire
    module EmojiExtension
      refine ::Emoji::Character do
        GITHUB_DOT_COM_ASSET_HOST_URL = "https://assets-cdn.github.com".freeze
        ASSET_PATH = "/images/icons/emoji".freeze

        def raw_unicode_character_html
          "<span class=\"emoji\" data-alias=\"#{name}\" " \
            "data-fallback=\"#{fallback_source}\">" \
            "#{raw}</span>"
        end

        def fallback_image_html
          "<span class=\"emoji\" data-alias=\"#{name}\" " \
            "style=\"overflow: hidden; display: inline-block; width: 1em; height: 1em; margin: 0 0.1em; background-size: 100% 100%; " \
            "background-image: url('#{fallback_source}');\"></span>"
        end

        def fallback_source
          File.join(GITHUB_DOT_COM_ASSET_HOST_URL, ASSET_PATH, image_filename)
        end
      end
    end
  end
end
