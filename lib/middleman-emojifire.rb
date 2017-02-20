require "middleman-core"
require "middleman-emojifire/version"

::Middleman::Extensions.register :emojifire do
  require "middleman-emojifire/extension"
  ::Middleman::Emojifire::Extension
end
