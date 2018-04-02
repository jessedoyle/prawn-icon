# encoding: utf-8
#
# compatibility.rb - Prawn::Icon FontAwesome 4/5 compatibility shim.
#
# Copyright March 2018, Jesse Doyle. All rights reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

# rubocop:disable Metrics/ClassLength
module Prawn
  class Icon
    class Compatibility
      SHIMS = {
        'fa-area-chart' => 'fas-chart-area',
        'fa-arrow-circle-o-down' => 'far-arrow-alt-circle-down',
        'fa-arrow-circle-o-left' => 'far-arrow-alt-circle-left',
        'fa-arrow-circle-o-right' => 'far-arrow-alt-circle-right',
        'fa-arrow-circle-o-up' => 'far-arrow-alt-circle-up',
        'fa-arrows' => 'fas-arrows-alt',
        'fa-arrows-alt' => 'fas-expand-arrows-alt',
        'fa-arrows-h' => 'fas-arrows-alt-h',
        'fa-arrows-v' => 'fas-arrows-alt-v',
        'fa-bar-chart' => 'far-chart-bar',
        'fa-bitbucket-square' => 'fab-bitbucket',
        'fa-calendar' => 'fas-calendar-alt',
        'fa-calendar-o' => 'far-calendar',
        'fa-caret-square-o-down' => 'far-caret-square-down',
        'fa-caret-square-o-left' => 'far-caret-square-left',
        'fa-caret-square-o-right' => 'far-caret-square-right',
        'fa-caret-square-o-up' => 'far-caret-square-up',
        'fa-cc' => 'far-closed-captioning',
        'fa-chain-broken' => 'fas-unlink',
        'fa-circle-o-notch' => 'fas-circle-notch',
        'fa-circle-thin' => 'far-circle',
        'fa-clipboard' => 'far-clipboard',
        'fa-clone' => 'far-clone',
        'fa-cloud-download' => 'fas-cloud-download-alt',
        'fa-cloud-upload' => 'fas-cloud-upload-alt',
        'fa-code-fork' => 'fas-code-branch',
        'fa-commenting' => 'fas-comment-alt',
        'fa-compass' => 'far-compass',
        'fa-copyright' => 'far-copyright',
        'fa-creative-commons' => 'fab-creative-commons',
        'fa-credit-card' => 'far-credit-card',
        'fa-credit-card-alt' => 'fas-credit-card',
        'fa-cutlery' => 'fas-utensils',
        'fa-diamond' => 'far-gem',
        'fa-eercast' => 'fab-sellcast',
        'fa-eur' => 'fas-euro-sign',
        'fa-exchange' => 'fas-exchange-alt',
        'fa-external-link' => 'fas-external-link-alt',
        'fa-external-link-square' => 'fas-external-link-square-alt',
        'fa-eye-dropper' => 'far-eye-dropper',
        'fa-eye-slash' => 'far-eye-slash',
        'fa-eyedropper' => 'fas-eye-dropper',
        'fa-facebook' => 'fab-facebook-f',
        'fa-facebook-official' => 'fab-facebook',
        'fa-file-text' => 'fas-file-alt',
        'fa-files-o' => 'far-copy',
        'fa-floppy-o' => 'far-save',
        'fa-gbp' => 'fas-pound-sign',
        'fa-glass' => 'fas-glass-martini',
        'fa-google-plus' => 'fab-google-plus-g',
        'fa-google-plus-circle' => 'fab-google-plus',
        'fa-google-plus-official' => 'fab-google-plus',
        'fa-hand-o-down' => 'far-hand-point-down',
        'fa-hand-o-left' => 'far-hand-point-left',
        'fa-hand-o-right' => 'far-hand-point-right',
        'fa-hand-o-up' => 'far-hand-point-up',
        'fa-header' => 'fas-heading',
        'fa-id-badge' => 'far-id-badge',
        'fa-ils' => 'fas-shekel-sign',
        'fa-inr' => 'fas-rupee-sign',
        'fa-intersex' => 'fas-transgender',
        'fa-jpy' => 'fas-yen-sign',
        'fa-krw' => 'fas-won-sign',
        'fa-level-down' => 'fas-level-down-alt',
        'fa-level-up' => 'fas-level-up-alt',
        'fa-life-ring' => 'far-life-ring',
        'fa-line-chart' => 'fas-chart-line',
        'fa-linkedin' => 'fab-linkedin-in',
        'fa-linkedin-square' => 'fab-linkedin',
        'fa-list-alt' => 'far-list-alt',
        'fa-long-arrow-down' => 'fas-long-arrow-alt-down',
        'fa-long-arrow-left' => 'fas-long-arrow-alt-left',
        'fa-long-arrow-right' => 'fas-long-arrow-alt-right',
        'fa-long-arrow-up' => 'fas-long-arrow-alt-up',
        'fa-map-marker' => 'fas-map-marker-alt',
        'fa-meanpath' => 'fab-font-awesome',
        'fa-mobile' => 'fas-mobile-alt',
        'fa-money' => 'far-money-bill-alt',
        'fa-object-group' => 'far-object-group',
        'fa-object-ungroup' => 'far-object-ungroup',
        'fa-paste' => 'far-paste',
        'fa-pencil' => 'fas-pencil-alt',
        'fa-pencil-square' => 'fas-pen-square',
        'fa-pencil-square-o' => 'far-edit',
        'fa-picture' => 'fas-image',
        'fa-pie-chart' => 'fas-chart-pie',
        'fa-refresh' => 'fas-sync',
        'fa-registered' => 'far-registered',
        'fa-repeat' => 'fas-redo',
        'fa-rub' => 'fas-ruble-sign',
        'fa-scissors' => 'fas-cut',
        'fa-shield' => 'fas-shield-alt',
        'fa-sign-in' => 'fas-sign-in-alt',
        'fa-sign-out' => 'fas-sign-out-alt',
        'fa-sliders' => 'fas-sliders-h',
        'fa-sort-alpha-asc' => 'fas-sort-alpha-down',
        'fa-sort-alpha-desc' => 'fas-sort-alpha-up',
        'fa-sort-amount-asc' => 'fas-sort-amount-down',
        'fa-sort-amount-desc' => 'fas-sort-amount-up',
        'fa-sort-asc' => 'fas-sort-up',
        'fa-sort-desc' => 'fas-sort-down',
        'fa-sort-numeric-asc' => 'fas-sort-numeric-down',
        'fa-sort-numeric-desc' => 'fas-sort-numeric-up',
        'fa-spoon' => 'fas-utensil-spoon',
        'fa-star-half-empty' => 'fas-star-half',
        'fa-star-half-full' => 'fas-star-half',
        'fa-support' => 'far-life-ring',
        'fa-tablet' => 'fas-tablet-alt',
        'fa-tachometer' => 'fas-tachometer-alt',
        'fa-television' => 'fas-tv',
        'fa-thumb-tack' => 'fas-thumbtack',
        'fa-thumbs-o-down' => 'far-thumbs-down',
        'fa-thumbs-o-up' => 'far-thumbs-up',
        'fa-ticket' => 'fas-ticket-alt',
        'fa-trash' => 'fas-trash-alt',
        'fa-trash-o' => 'far-trash-alt',
        'fa-try' => 'fas-lira-sign',
        'fa-usd' => 'fas-dollar-sign',
        'fa-video-camera' => 'fas-video',
        'fa-vimeo' => 'fab-vimeo-v',
        'fa-volume-control-phone' => 'fas-phone-volume',
        'fa-wheelchair-alt' => 'fab-accessible-icon',
        'fa-window-maximize' => 'far-window-maximize',
        'fa-window-restore' => 'far-window-restore',
        'fa-youtube-play' => 'fab-youtube'
      }.freeze

      attr_accessor :key

      def initialize(opts = {})
        self.key = opts.fetch(:key)
      end

      def translate(io = STDERR)
        @translate ||= begin
          if key.start_with?('fa-')
            map.tap { |replaced| warning(replaced, key, io) }
          else
            key
          end
        end
      end

      private

      def map
        SHIMS.fetch(key) do
          # FontAwesome shim metadata assumes "fas" as the default
          # font family if not explicity referenced.
          "fas-#{key.sub(/fa-/, '')}"
        end
      end

      def warning(new_key, old_key, io)
        io.puts <<-DEPRECATION
[Prawn::Icon - DEPRECATION WARNING]
  FontAwesome 4 icon was referenced as '#{old_key}'.
  Use the FontAwesome 5 icon '#{new_key}' instead.
  This compatibility layer will be removed in Prawn::Icon 3.0.0.
DEPRECATION
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
