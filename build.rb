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
      yellow:   "#b58900",
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
      yellow:   "#b58900",
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
    @palette = OpenStruct.new(SOLARIZED_PALETTE[@mode])
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
        palette.green, palette.red, palette.blue, palette.magenta,
        palette.base1, palette.orange, palette.orange
      ),
      uicolor: palette.base0,
      uifgcolor: palette.base1,
      uifgdisabledcolor: palette.base03,
      bgcolor: palette.base03,
      fgcolor: palette.base1,
      selectbgcolor: palette.base02,
      diffcolors: format("{%s %s %s}", palette.red, palette.green, palette.cyan),
      diffbgcolors: format("{%s %s}", palette.base02, palette.base02),
      mergecolors: format(
        "{%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s}",
        palette.red, palette.blue, palette.green, palette.blue,
        palette.orange, palette.cyan, palette.magenta, palette.yellow,
        palette.cyan, palette.magenta, palette.cyan, palette.orange,
        palette.cyan, palette.green, palette.orange, palette.magenta
      ),
      markbgcolor: palette.base03,
      headbgcolor: palette.green,
      headfgcolor: palette.base2,
      headoutlinecolor: palette.base1,
      remotebgcolor: palette.orange,
      tagbgcolor: palette.yellow,
      tagfgcolor: palette.base2,
      tagoutlinecolor: palette.base1,
      reflinecolor: palette.base1,
      filesepbgcolor: palette.base01,
      filesepfgcolor: palette.base2,
      linehoverbgcolor: palette.yellow,
      linehoverfgcolor: palette.base2,
      linehoveroutlinecolor: palette.base1,
      mainheadcirclecolor: palette.yellow,
      workingfilescirclecolor: palette.red,
      indexcirclecolor: palette.green,
      circlecolors: format(
        "{%s %s %s %s %s}",
        palette.base3, palette.blue, palette.base02, palette.blue, palette.blue
      ),
      linkfgcolor: palette.blue,
      circleoutlinecolor: palette.base0,
      foundbgcolor: palette.yellow,
      currentsearchhitbgcolor: palette.orange,
    }.tap do |config|
      if mode == :light
        config.update({
          uicolor: palette.base02,
          filesepbgcolor: palette.base01,
        })
      else
        config.update({
        })
      end
    end
  end
end

if $0 == __FILE__
  BuildGitkSolarized.call(ARGV[0])
end
