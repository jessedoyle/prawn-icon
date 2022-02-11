# frozen_string_literal: true
#
# tool/fontawesome.rb: Convert Fontawesome SCSS variables to YAML legend.
#
# Copyright September 2017, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require_relative 'fontawesome/converter'

puts 'Please enter the path to the icons.yml metadata file ' \
'(i.e. fontawesome-free/advanced-options/icons.yml):'
path = File.expand_path(gets.chomp)
output = File.expand_path('data/fonts')
puts 'Please enter the font version:'
version = gets.chomp

Fontawesome::Converter.new(
  version: version,
  output: output,
  path: path
)
