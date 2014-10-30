# encoding: utf-8
#
# Copyright October 2014, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'spec_helper'

describe Prawn::Icon::Interface do
  describe '::icon' do
    context 'valid icon key' do
      context 'with options' do
        it 'should handle text options (size)' do
          pdf = create_pdf
          pdf.icon 'fa-arrows', size: 60
          text = PDF::Inspector::Text.analyze(pdf.render)

          expect(text.font_settings.first[:size]).to eq(60)
        end
      end

      context 'inline_format: true' do
        it 'should handle text options (size)' do
          pdf = create_pdf
          # We need to flush the font cache here...
          Prawn::Icon::FontData.release_data
          pdf.icon '<icon size="60">fa-arrows</icon>', inline_format: true
          text = PDF::Inspector::Text.analyze(pdf.render)

          expect(text.strings.first).to eq("\uf047")
          expect(text.font_settings.first[:size]).to eq(60.0)
        end
      end

      context 'without options' do
        it 'should render an icon to document' do
          pdf = create_pdf
          pdf.icon 'fa-arrows'
          text = PDF::Inspector::Text.analyze(pdf.render)

          expect(text.strings.first).to eq("\uf047")
        end
      end
    end

    context 'invalid icon key' do
      it 'should raise IconNotFound' do
        pdf = create_pdf
        proc = Proc.new { pdf.icon 'fa-__INVALID' }

        expect(proc).to raise_error(Prawn::Errors::IconNotFound)
      end
    end

    context 'invalid specifier' do
      it 'should raise UnknownFont' do
        pdf = create_pdf
        proc = Proc.new { pdf.icon '__INVALID__' }

        expect(proc).to raise_error(Prawn::Errors::UnknownFont)
      end
    end
  end

  describe '::make_icon' do
    context ':inline_format => false (default)' do
      it 'should return a Prawn::Icon instance' do
        pdf = create_pdf
        icon = pdf.make_icon 'fa-arrows'

        expect(icon.class).to eq(Prawn::Icon)
      end
    end

    context ':inline_format => true' do
      it 'should return a Prawn::::Text::Formatted::Box instance' do
        pdf = create_pdf
        icon = pdf.make_icon '<icon>fa-arrows</icon>', inline_format: true

        expect(icon.class).to eq(Prawn::Text::Formatted::Box)
      end
    end
  end

  describe '::inline_icon' do
    it 'should return a Prawn::Text::Formatted::Box instance' do
      pdf = create_pdf
      icon = pdf.inline_icon '<icon>fa-arrows</icon>'

      expect(icon.class).to eq(Prawn::Text::Formatted::Box)
    end
  end
end