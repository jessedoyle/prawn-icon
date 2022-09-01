# frozen_string_literal: true

# tool/mdi.rb: Convert Material Design SCSS variables to YAML legend.
#
# Copyright August 31, 2022 Jesse Doyle, Perceval Anichini. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require_relative 'scss/parser'

PREFIX = /\s"(?<key>.+)":\s*(?<unicode>.*),?/.freeze
VERSION = /mdi-version:\s*"(?<version>.*)"/.freeze

puts 'Please enter in the path to the _variables.scss file:'
path = File.expand_path(gets.chomp)
puts 'Enter the output file path:'
output = File.expand_path(gets.chomp)

SCSS::Parser.new(
  prefix: PREFIX,
  version: VERSION,
  specifier: 'mdi',
  path: path,
  output: output
)
