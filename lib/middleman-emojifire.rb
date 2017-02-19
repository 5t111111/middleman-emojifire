require "middleman-core"

Middleman::Extensions.register :middleman-emojifire do
  require "my-extension/extension"
  MyExtension
end
