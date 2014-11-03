# encoding: utf-8
#
# Copyright October 2014, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'spec_helper'

describe Prawn::Icon::FontData do
  describe '#initialize' do
    it 'should update font_families on initialization' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)

      expect(pdf.font_families['fa']).not_to be_nil
    end
  end

  describe '::load' do
    it 'should only load a single object for multiple documents' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.load(pdf, 'fa')
      obj_id_1 = data.__id__
      data = Prawn::Icon::FontData.load(pdf, 'fa')
      obj_id_2 = data.__id__

      expect(obj_id_1).to eq(obj_id_2)
    end

    it 'should accept a string as a specifier' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.load(pdf, 'fa')

      expect(data).not_to be_nil
    end

    it 'should accept a symbol as a specifer' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.load(pdf, :fa)

      expect(data).not_to be_nil
    end
  end

  describe '::release_data' do
    it 'should remove all data references if requested' do
      pdf = create_pdf
      Prawn::Icon::FontData.load(pdf, :fa)
      Prawn::Icon::FontData.load(pdf, :fi)
      Prawn::Icon::FontData.load(pdf, :octicon)
      data = Prawn::Icon::FontData.release_data

      expect(data).to be_empty
    end
  end

  describe '::unicode_from_key' do
    it 'should provide a UTF-8 string for a valid key' do
      pdf = create_pdf
      unicode = Prawn::Icon::FontData.unicode_from_key(pdf, 'fa-arrows')
      valid = unicode.force_encoding('UTF-8').valid_encoding?

      expect(valid).to be_true
    end
  end

  describe '::specifier_from_key' do
    it 'should provide the font specifier from a valid key' do
      specifier = Prawn::Icon::FontData.specifier_from_key('fa-arrows')
      expect(specifier).to eq(:fa)
    end

    it 'should error when key is nil' do
      proc = Proc.new { Prawn::Icon::FontData.specifier_from_key nil }

      expect(proc).to raise_error(Prawn::Errors::IconKeyEmpty)
    end

    it 'should error when key is an empty string' do
      proc = Proc.new { Prawn::Icon::FontData.specifier_from_key '' }

      expect(proc).to raise_error(Prawn::Errors::IconKeyEmpty)
    end

    it 'should handle strings without any dashes properly' do
      specifier = Prawn::Icon::FontData.specifier_from_key 'foo'

      expect(specifier).to eq(:foo)
    end
  end

  describe '#font_version' do
    it 'should have a font version as a string' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf)
      version = data.font_version

      expect(version.is_a? String).to be_true
    end
  end

  describe '#legend_path' do
    it 'should have a valid path to a yml file for legend' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf)
      path = data.legend_path
      extname = File.extname(path)

      expect(extname).to eq('.yml')
    end
  end

  describe '#load_fonts' do
    it 'should return a FontData object' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf)
      ret_val = data.load_fonts(pdf)

      expect(ret_val.is_a? Prawn::Icon::FontData).to be_true
    end
  end

  describe '#path' do
    it 'should have a valid path to a TTF file' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf)
      path = data.path
      extname = File.extname(path)

      expect(extname).to eq('.ttf')
    end
  end

  describe '#specifier' do
    it 'should retrieve the string specifier from the yaml legend file' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)
      specifier = data.specifier

      expect(specifier).to eq('fa')
    end
  end

  describe '#unicode' do
    it 'should provide a valid UTF-8 encoded string for a valid key' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)
      unicode = data.unicode('arrows')
      valid = unicode.force_encoding('UTF-8').valid_encoding?

      expect(valid).to be_true
    end

    it 'should raise an error if unable to match a key' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)
      proc = Proc.new { data.unicode('an invalid sequence') }

      expect(proc).to raise_error(Prawn::Errors::IconNotFound)
    end
  end

  describe '#keys' do
    it 'should return a non-empty array of strings' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)
      keys = data.keys

      expect(keys).not_to be_empty
      expect(keys.first.is_a? String).to be_true
    end

    it 'should not contain the version as a key' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)
      keys = data.keys

      expect(keys.include?('__font_version__')).to be_false
    end
  end

  describe '#yaml' do
    it 'should return a hash with the specifier as the first key' do
      pdf = create_pdf
      data = Prawn::Icon::FontData.new(pdf, set: :fa)
      yaml = data.yaml
      key = yaml.keys.first
      mapping = yaml['fa']
      inner_key = mapping.keys.last
      inner_value = mapping.values.last
      proc = Proc.new { inner_value.force_encoding('UTF-8').valid_encoding? }

      expect(yaml.is_a? Hash).to be_true
      expect(key).to eq('fa')
      expect(inner_key.is_a? String).to be_true
      expect(inner_value.is_a? String).to be_true
      expect(proc).to be_true
    end
  end
end
