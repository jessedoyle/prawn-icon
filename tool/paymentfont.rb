# encoding: utf-8

#
# tool/fontawesome.rb: Convert PaymentFont SCSS variables to YAML legend.
#
# Copyright September 2017, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require_relative 'scss/parser'

PREFIX = /pf-var-(?<key>.+):\s*"\\(?<unicode>.*)";/
VERSION = /pf-version:\s*"(?<version>.*)"/

puts 'Please enter in the path to the _variables.scss file:'
path = File.expand_path(gets.chomp)
puts 'Enter the output file path:'
output = File.expand_path(gets.chomp)

SCSS::Parser.new(
  prefix: PREFIX,
  version: VERSION,
  specifier: 'pf',
  path: path,
  output: output
)
