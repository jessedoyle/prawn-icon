# frozen_string_literal: true

# tool/scss/parser.rb: Convert SCSS variables to YAML legend.
#
# Copyright September 2017, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'yaml'

module SCSS
  class Parser
    attr_accessor :path, :output, :data, :prefix, :version, :specifier

    def initialize(opts = {})
      self.specifier = opts.fetch(:specifier)
      self.prefix = opts.fetch(:prefix)
      self.version = opts.fetch(:version)
      self.path = opts.fetch(:path)
      self.data = File.read(path)
      self.output = opts.fetch(:output)
      parse
    end

    private

    def parse
      matches = data.scan(prefix)
      initial = {
        specifier => {
          '__font_version__' => data.scan(version).flatten.first
        }
      }
      yaml = matches.each_with_object(initial) do |match, hash|
        key, value = match
        hash[specifier][key] = [value.hex].pack('U')
        hash
      end
      File.write(output, yaml.to_yaml)
    end
  end
end
