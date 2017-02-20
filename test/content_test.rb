require "test_helper"
require "middleman-emojifire/content"

describe Middleman::Emojifire::Content do
  describe "initialize" do
    it "saves stringified content" do
      content = Middleman::Emojifire::Content.new(123)
      expect(content.source).must_be_instance_of String
    end
  end

  describe "include_body?" do
    it "returns true if including body tag" do
      content = Middleman::Emojifire::Content.new(
        <<~EOS
          <head>
            <title>Test</title>
          </head>
          <body>
            Test
          </body>
        EOS
      )
      expect(content.include_body?).must_equal true
    end

    it "returns true if including body tag with attributes" do
      content = Middleman::Emojifire::Content.new(
        <<~EOS
          <body class="main">
            Test
          </body>
        EOS
      )
      expect(content.include_body?).must_equal true
    end

    it "returns false if not including body tag" do
      content = Middleman::Emojifire::Content.new(
        <<~EOS
          <head>
            <title>Test</title>
          </head>
        EOS
      )
      expect(content.include_body?).must_equal false
    end

    it "returns false if including body but not tag" do
      content = Middleman::Emojifire::Content.new(
        <<~EOS
          body
          /body
        EOS
      )
      expect(content.include_body?).must_equal false
    end
  end

  describe "body_only" do
    it "yields body of content only" do
      content = Middleman::Emojifire::Content.new(
        <<~EOS
          <head>
            <title>Test</title>
          </head>
          <body>Expect this to be yielded</body>
        EOS
      )

      content.body_only do |body|
        expect(body).must_equal "<body>Expect this to be yielded</body>"
      end
    end

    it "returns substituted content" do
      content = Middleman::Emojifire::Content.new("<head></head><body>Expect this to be substituted</body>")
      substituted_content = content.body_only { |body| "<body>substituted!</body>" }
      expect(substituted_content).must_equal "<head></head><body>substituted!</body>"
    end
  end

  describe "to_s" do
    it "returns source" do
      content = Middleman::Emojifire::Content.new("pewpewpew")
      expect(content.to_s).must_equal "pewpewpew"
    end
  end
end
