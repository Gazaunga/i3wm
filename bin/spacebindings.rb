#!/usr/bin/env ruby

## VARS ##

Alias_File = File.open("#{Dir.home}/bin/spacemacs-keybindings", "r")

reader = ->line { puts line }

## MAIN ##

Alias_File.each_line &reader

# IO.foreach("#{Dir.home}/bin/spacemacs-keybindings") &reader
