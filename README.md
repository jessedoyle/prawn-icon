# Prawn::Icon

Prawn::Icon provides a simple mechanism for rendering icons and icon fonts from within Prawn.

The following icon fonts ship with Prawn::Icon:

* FontAwesome (http://fontawesome.io/icons/)
* Foundation Icons (http://zurb.com/playground/foundation-icon-fonts-3)
* GitHub Octicons (https://octicons.github.com)

Prawn::Icon was originally written by Jesse Doyle.

## Installation

Prawn::Icon is distributed via RubyGems. You can install it with the following command:

```bash
gem install prawn-icon
```

## Usage

Prawn::Icon was designed to have an API familiar to Prawn. A single icon may be rendered as such:

```ruby
require 'prawn'
require 'prawn/icon'

Prawn::Document.generate('icons.pdf') do |pdf|
  pdf.icon 'fa-beer', size: 60
end
```

produces:

![FontAwesome Beer](https://raw.github.com/jessedoyle/prawn-icon/master/examples/fa-beer.png)

## Inline Icons

You can also provide the `inline_format: true` option to Prawn::Icon:

```ruby
require 'prawn'
require 'prawn/icon'

Prawn::Document.generate('inline_icons.pdf') do |pdf|
  pdf.icon 'Enjoy: <icon size="20" color="AAAAAA">fa-beer</icon>', inline_format: true
end
```

produces:

![FontAwesome Beer Inline](https://raw.github.com/jessedoyle/prawn-icon/master/examples/fa-beer-inline.png)

When using `inline_format: true`, you may supply `<icon>` tags with `color` and `size` attributes.

## How It Works

Prawn::Icon uses a "legend" to map icon keys to unicode characters that respresent a particular icon within the font file.

This legend is a standard `.yml` file located within the font's directory.

If you wish to fork this repository and add a new font, you'll likely need to supply a corresponding legend file. Please see the current legend files within the `fonts` directory for examples.

## Examples

A Rake task is included to generate documents that display each icon and it's corresponding icon key.

The command:

```bash
rake legend
```

should generate these files when run from Prawn::Icon's gem directory.

## Contributing

I'll gladly accept pull requests that are well tested for any bug found in Prawn::Icon.

If there is enough demand for including a particular icon font, I will also accept a pull request to include it in Prawn::Icon.

## License

Prawn::Icon is licensed under the same terms that are used by Prawn.

You may choose between Matz's terms, the GPLv2, or GPLv3. For details, please see the LICENSE, GPLv2, and GPLv3 files.
