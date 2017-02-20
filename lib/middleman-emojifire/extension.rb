require "middleman-core"
require "middleman-emojifire/converter"

module Middleman
  module Emojifire
    class Extension < ::Middleman::Extension
      def initialize(app, options_hash={}, &block)
        super
        require "gemoji"

        app.after_render do |content|
          ::Middleman::Emojifire::Converter.new(content).convert
        end
      end
    end
  end
end
