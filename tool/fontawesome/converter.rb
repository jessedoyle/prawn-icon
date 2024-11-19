# frozen_string_literal: true

# tool/fontawesome/converter.rb: Convert FontAweomse metadata to YAML.
#
# Copyright March 2018, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'yaml'
require 'fileutils'

module Fontawesome
  class Converter
    attr_accessor :path, :output, :data, :version, :legends

    def initialize(opts = {})
      self.version = opts.fetch(:version)
      self.path = opts.fetch(:path)
      self.data = YAML.load_file(path)
      self.output = opts.fetch(:output)
      self.legends = {
        'fab' => {
          '__font_version__' => version
        },
        'far' => {
          '__font_version__' => version
        },
        'fas' => {
          '__font_version__' => version
        }
      }
      parse
    end

    private

    def parse
      prepare_legends
      write_legends
    end

    def prepare_legends
      data.each do |key, value|
        prepare_legend(key, value)
      end
    end

    def prepare_legend(key, value)
      styles = value['styles'].map { |s| "fa#{s[0]}" }
      unicode = [value['unicode'].hex].pack('U')
      styles.each do |style|
        legends[style][key] = unicode
        aliases = value.fetch('aliases', {})
        alias_names = aliases.fetch('names', [])
        alias_names.each do |alias_name|
          legends[style][alias_name] = unicode
        end
      end
    end

    def write_legends
      legends.each do |key, value|
        ordered_value = {}
        value.keys.sort.each do |sorted_key|
          ordered_value[sorted_key] = value[sorted_key]
        end

        directory = File.join(output, key)
        FileUtils.mkdir_p(directory)
        path = File.join(directory, "#{key}.yml")
        File.write(path, { key => ordered_value }.to_yaml)
        puts "Wrote: #{path}"
      end
    end
  end
end
