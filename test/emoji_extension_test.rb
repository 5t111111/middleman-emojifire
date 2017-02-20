require "test_helper"
require "middleman-emojifire/ext/emoji_extension"

class Dummy
  using Middleman::Emojifire::EmojiExtension

  def initialize
    @emoji = Emoji::Character.new("cat")
  end

  def raw_unicode_character_html_test
    @emoji.raw_unicode_character_html
  end

  def fallback_image_html_test
    @emoji.fallback_image_html
  end
end

describe Middleman::Emojifire::EmojiExtension do
  describe "raw_unicode_character_html" do
    it "returns html for displaying raw unicode emoji character" do
      dummy_class = Dummy.new
      html = '<span class="emoji" data-alias="cat" ' \
        'data-fallback="https://assets-cdn.github.com/images/icons/emoji/cat.png"></span>'
      expect(dummy_class.raw_unicode_character_html_test).must_equal html
    end
  end

  describe "fallback_image_html" do
    it "returns html for displaying fallback image instead of raw unicode emoji character" do
      dummy_class = Dummy.new
      html = '<span class="emoji" data-alias="cat" style="overflow: hidden; display: ' \
        'inline-block; width: 1em; height: 1em; margin: 0 0.1em; background-size: 100% 100%; ' \
        'background-image: url(\'https://assets-cdn.github.com/images/icons/emoji/cat.png\');"></span>'
      expect(dummy_class.fallback_image_html_test).must_equal html
    end
  end
end
