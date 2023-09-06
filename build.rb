#!/usr/bin/env ruby

require "erb"

class BuildGitkSolarized
  TEMPLATE = <<~GITK_CONFIG
    set want_ttk 0
    set uicolor                 <%= uicolor %>
    set uifgcolor               <%= uifgcolor %>
    set uifgdisabledcolor       <%= uifgdisabledcolor %>
    set bgcolor                 <%= bgcolor %>
    set fgcolor                 <%= fgcolor %>
    set colors                  <%= colors %>
    set diffcolors              <%= diffcolors %>
    set mergecolors             <%= mergecolors %>
    set markbgcolor             <%= markbgcolor %>
    set selectbgcolor           <%= selectbgcolor %>
    set foundbgcolor            <%= foundbgcolor %>
    set currentsearchhitbgcolor <%= currentsearchhitbgcolor %>
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
    set diffbgcolors            <%= diffbgcolors %>
  GITK_CONFIG

  def initialize(mode = "dark")
    @mode = mode
  end

  def call
    config = ERB.new(TEMPLATE).result_with_hash(gitk_config)
    puts config
  end

  def self.call(...)
    new(...).call
  end

  private

  def gitk_config
    {
      uicolor: nil,
      uifgcolor: nil,
      uifgdisabledcolor: nil,
      bgcolor: nil,
      fgcolor: nil,
      colors: nil,
      diffcolors: nil,
      mergecolors: nil,
      markbgcolor: nil,
      selectbgcolor: nil,
      foundbgcolor: nil,
      currentsearchhitbgcolor: nil,
      headbgcolor: nil,
      headfgcolor: "black",
      headoutlinecolor: nil,
      remotebgcolor: nil,
      tagbgcolor: nil,
      tagfgcolor: "black",
      tagoutlinecolor: nil,
      reflinecolor: nil,
      filesepbgcolor: nil,
      filesepfgcolor: nil,
      linehoverbgcolor: nil,
      linehoverfgcolor: "black",
      linehoveroutlinecolor: nil,
      mainheadcirclecolor: nil,
      workingfilescirclecolor: nil,
      indexcirclecolor: nil,
      circlecolors: nil,
      linkfgcolor: nil,
      circleoutlinecolor: nil,
      diffbgcolors: nil,
    }
  end
end

if $0 == __FILE__
  BuildGitkSolarized.call(ARGV[1])
end
