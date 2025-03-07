#!/usr/bin/env ruby

require "erb"
require "ostruct"

class BuildGitkSolarized
  TEMPLATE = <<~GITK_CONFIG
    set want_ttk                0
    set colors                  <%= colors %>
    set uicolor                 <%= uicolor %>
    set uifgcolor               <%= uifgcolor %>
    set uifgdisabledcolor       <%= uifgdisabledcolor %>
    set bgcolor                 <%= bgcolor %>
    set fgcolor                 <%= fgcolor %>
    set selectbgcolor           <%= selectbgcolor %>
    set diffcolors              <%= diffcolors %>
    set diffbgcolors            <%= diffbgcolors %>
    set mergecolors             <%= mergecolors %>
    set markbgcolor             <%= markbgcolor %>
    set headbgcolor             <%= headbgcolor %>
    set headfgcolor             <%= headfgcolor %>
    set headoutlinecolor        <%= headoutlinecolor %>
    set remotebgcolor           <%= remotebgcolor %>
    set tagbgcolor              <%= tagbgcolor %>
    set tagfgcolor              <%= tagfgcolor %>
    set tagoutlinecolor         <%= tagoutlinecolor %>
    set reflinecolor            <%= reflinecolor %>
    set filesepbgcolor          <%= filesepbgcolor %>
    set filesepfgcolor          <%= filesepfgcolor %>
    set linehoverbgcolor        <%= linehoverbgcolor %>
    set linehoverfgcolor        <%= linehoverfgcolor %>
    set linehoveroutlinecolor   <%= linehoveroutlinecolor %>
    set mainheadcirclecolor     <%= mainheadcirclecolor %>
    set workingfilescirclecolor <%= workingfilescirclecolor %>
    set indexcirclecolor        <%= indexcirclecolor %>
    set circlecolors            <%= circlecolors %>
    set linkfgcolor             <%= linkfgcolor %>
    set circleoutlinecolor      <%= circleoutlinecolor %>
    set foundbgcolor            <%= foundbgcolor %>
    set currentsearchhitbgcolor <%= currentsearchhitbgcolor %>
  GITK_CONFIG

  #
  # Terminal Colors
  #
  # Black           Dark Gray
  # Blue            Light Blue
  # Green           Light Green
  # Cyan            Light Cyan
  # Red             Light Red
  # Purple          Light Purple
  # Brown           Yellow
  # Light Gray      White
  #
  # Dark Colors:  base02 red    green  yellow blue   magenta cyan   base2
  #               base03 orange base01 base00 base0  violet  base1  base3
  #
  # Light Colors: base2  red    green  yellow blue   magenta cyan   base02
  #               base3  orange base1  base0  base00 violet  base01 base03
  #
  SOLARIZED_PALETTE = {
    dark: {
      base03:   "#002b36",
      darkgray: "#002b36",
      darkgrey: "#002b36",
      base02:   "#073642",
      black:    "#073642",
      base01:   "#586e75",
      base00:   "#657b83",
      base0:    "#839496",
      base1:    "#93a1a1",
      base2:    "#eee8d5",
      gray:     "#eee8d5",
      grey:     "#eee8d5",
      base3:    "#fdf6e3",
      white:    "#fdf6e3",
      yellow:   "#ffff00",
      brown:    "#b58900",
      orange:   "#cb4b16",
      red:      "#dc322f",
      magenta:  "#d33682",
      purple:   "#d33682",
      violet:   "#6c71c4",
      blue:     "#268bd2",
      cyan:     "#2aa198",
      aqua:     "#2aa198",
      green:    "#859900",
    },
    light: {
      base03:   "#fdf6e3",
      white:    "#fdf6e3",
      base02:   "#eee8d5",
      gray:     "#eee8d5",
      grey:     "#eee8d5",
      base01:   "#93a1a1",
      base00:   "#839496",
      base0:    "#657b83",
      base1:    "#586e75",
      base2:    "#073642",
      black:    "#073642",
      base3:    "#002b36",
      darkgray: "#002b36",
      darkgrey: "#002b36",
      yellow:   "#ffff00",
      brown:    "#b58900",
      orange:   "#cb4b16",
      red:      "#dc322f",
      magenta:  "#d33682",
      purple:   "#d33682",
      violet:   "#6c71c4",
      blue:     "#268bd2",
      cyan:     "#2aa198",
      aqua:     "#2aa198",
      green:    "#859900",
    },
  }.freeze

  def initialize(mode = "dark")
    @mode = (mode || "dark").to_sym
    @palette = build_palette
  end

  def call
    config = ERB.new(TEMPLATE).result_with_hash(gitk_config)
    puts config
  end

  def self.call(...)
    new(...).call
  end

  private

  attr_reader :mode, :palette

  def gitk_config
    {
      colors: format(
        "{%s %s %s %s %s %s %s}",
        *[
          palette.green, palette.red, palette.blue, palette.magenta,
          palette.base01, palette.brown, palette.orange,
        ].map(&:inspect)
      ),
      uicolor: palette.base02,
      uifgcolor: palette.base1,
      uifgdisabledcolor: palette.base3,
      bgcolor: palette.background,
      fgcolor: palette.foreground,
      selectbgcolor: palette.selection,
      diffcolors: format("{%s %s %s}", *[palette.red, palette.green, palette.cyan].map(&:inspect)]),
      diffbgcolors: format("{%s %s}", *[palette.selection, palette.selection].map(&:inspect)]),
      mergecolors: format(
        "{%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s}",
        *[
          palette.red, palette.blue, palette.green, palette.purple,
          palette.brown, palette.cyan, palette.magenta, palette.yellow,
          palette.green, palette.magenta, palette.cyan, palette.orange,
          palette.blue, palette.green, palette.orange, palette.magenta,
        ].map(&:inspect)
      ),
      markbgcolor: palette.background,
      headbgcolor: palette.head,
      headfgcolor: palette.black,
      headoutlinecolor: palette.background,
      remotebgcolor: palette.remote,
      tagbgcolor: palette.yellow,
      tagfgcolor: palette.black,
      tagoutlinecolor: palette.background,
      reflinecolor: palette.black,
      filesepbgcolor: palette.base01,
      filesepfgcolor: palette.base2,
      linehoverbgcolor: palette.yellow,
      linehoverfgcolor: palette.black,
      linehoveroutlinecolor: palette.background,
      mainheadcirclecolor: palette.yellow,
      workingfilescirclecolor: palette.red,
      indexcirclecolor: palette.green,
      circlecolors: format(
        "{%s %s %s %s %s}",
        *[palette.background, palette.blue, palette.base2, palette.blue, palette.blue].map(&:inspect)
      ),
      linkfgcolor: palette.blue,
      circleoutlinecolor: palette.black,
      foundbgcolor: palette.search,
      currentsearchhitbgcolor: palette.base00,
    }
  end

  def build_palette
    OpenStruct.new(SOLARIZED_PALETTE[@mode]).tap do |palette|
      palette.background = palette.base03
      palette.foreground = palette.base0
      palette.selection  = palette.base02
      palette.search     = "#ffac1c"
      palette.remote     = "#ffac1c"
      palette.head       = "#719e07"
    end
  end
end

if $0 == __FILE__
  BuildGitkSolarized.call(ARGV[0])
end
