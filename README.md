# middleman-emojifire 🔥

middleman-emojifire is a quite easy-to-use emoji extension for Middleman.

Given the below HTML source:

```html
<h3>The love :cat:</h3>
<p>I move like cagey :tiger:</p>
```

middleman-emojifire will convert it into like the following:

```html
<h3>The love 🐱</h3>
<p>I move like cagey 🐯</p>
```

In fact, emojifire wraps emojis with `<span>` tags for future use (as be described later):

```html
<h3>The love <span class="emoji" data-alias="cat" data-fallback="https://assets-cdn.github.com/images/icons/emoji/unicode/1f431.png">🐱</span></h3>
```


Note that these emojis are characters respresented by unicode.
Unlike the ways of most extensions to display emoji, they are not replaced by images.
This means that modern OS/browsers can display them without extra downloads.

However, what if you want to put popular emoji which does not have unicode representation like :shipit:?

When a unicode repsentation for an emoji is not found, emojifire fallbacks it to an image with inline styles:

```html
<span class="emoji" data-alias="shipit" style="overflow: hidden; display: inline-block; width: 1em; height: 1em; margin: 0 0.1em; background-size: 100% 100%; background-image: url('https://assets-cdn.github.com/images/icons/emoji/shipit.png');"></span>
```

## Usage

Add the following to Gemfile:

```ruby
gem "middleman-emojifire"
```

And add the following to your `config.rb`:

```ruby
activate :emojifire
```

That's all.

## Fallback on platforms which do not natively support emoji

Since middleman-emojifire set some data-attributes including an image source URL in tag, you can easily write a fallback script to display images instead of characters.

Simply adding the below snippet into your JavaScript assets will work:

```javascript
document.addEventListener('DOMContentLoaded', function() {
  var emojiSupported = (function() {
    var node = document.createElement('canvas');
    if (!node.getContext || !node.getContext('2d') ||
      typeof node.getContext('2d').fillText !== 'function')
      return false;
    var ctx = node.getContext('2d');
    ctx.textBaseline = 'top';
    ctx.font = '32px Arial';
    ctx.fillText('\ud83d\ude03', 0, 0);
    return ctx.getImageData(16, 16, 1, 1).data[0] !== 0;
  })();

  if (emojiSupported) { return; }

  var emojiElements = document.getElementsByClassName('emoji');

  for (var i = 0; i < emojiElements.length; i++) {
    var element = emojiElements[i];
    var srcPath = element.dataset.fallback;
    if (typeof srcPath !== 'undefined') {
      element.innerHTML = '';
      element.style.overflow = 'hidden';
      element.style.display = 'inline-block';
      element.style.width = '1em';
      element.style.height = '1em';
      element.style.margin = '0 0.1em';
      element.style.backgroundSize =  '100% 100%';
      element.style.backgroundImage = "url('" + srcPath + "')";
      delete element.dataset.fallback;
    }
  }
});
```

It will detect if a platform supports emoji, and fallback to images if it does not.

## Thanks

- [middleman-gemoji](https://github.com/yterajima/middleman-gemoji) as reference for both concept and implementation
- http://crocodillon.com/blog/parsing-emoji-unicode-in-javascript for native emoji support detection snippet in JS
