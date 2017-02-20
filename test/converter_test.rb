require "test_helper"
require "middleman-emojifire/converter"

describe Middleman::Emojifire::Converter do
  describe "convert" do
    it "converted emoji aliases in content with body" do
      converter = Middleman::Emojifire::Converter.new(
        <<~EOS
          <head>
            <title>:cat:</title>
          </head>
          <body>
            :cat:
            :shipit:
          </body>
        EOS
      )

      html = <<~EOS
        <head>
          <title>:cat:</title>
        </head>
        <body>
          <span class="emoji" data-alias="cat" data-fallback="https://assets-cdn.github.com/images/icons/emoji/unicode/1f431.png">🐱</span>
          <span class="emoji" data-alias="shipit" style="overflow: hidden; display: inline-block; width: 1em; height: 1em; margin: 0 0.1em; background-size: 100% 100%; background-image: url('https://assets-cdn.github.com/images/icons/emoji/shipit.png');"></span>
        </body>
       EOS

      expect(converter.convert).must_equal html
    end

    it "converted emoji aliases in content without body" do
      converter = Middleman::Emojifire::Converter.new(
        <<~EOS
          :cat:
          :shipit:
        EOS
      )

      html = <<~EOS
        <span class="emoji" data-alias="cat" data-fallback="https://assets-cdn.github.com/images/icons/emoji/unicode/1f431.png">🐱</span>
        <span class="emoji" data-alias="shipit" style="overflow: hidden; display: inline-block; width: 1em; height: 1em; margin: 0 0.1em; background-size: 100% 100%; background-image: url('https://assets-cdn.github.com/images/icons/emoji/shipit.png');"></span>
       EOS

      expect(converter.convert).must_equal html
    end
  end
end
