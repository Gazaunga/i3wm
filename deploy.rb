#!/usr/bin/env ruby

require 'fileutils'

DESTINATION = "#{Dir.home}/"

apps = %w[
  mpd
  ncmpcpp
  zsh
  dunst
  i3-gaps
  qutebrowser
  firefox
  rxvt-unicode
  emacs
  feh
  youtube-dl-git
  i3lock
  compton
  zathura
  zathura-pdf-mupdf
  kitty-git
]

install = ->app{ `trizen -Syu --noconfirm #{app}` }

def grab_wallpaper
status = system("git clone https://github.com/jeremyottley/.wallpapers ~/.wallpapers")
puts status ? "Success" : "Failed"
end

def grab_fonts
status = system("git clone https://github.com/jeremyottley/.fonts ~/.fonts")
puts status ? "Success" : "Failed"
`fc-cache -fv`
end

## MAIN ##
grab_wallpaper
grab_fonts
Dir.glob("#{Dir.home}/i3wm/.", File::FNM_DOTMATCH).each { |f| FileUtils.cp_r("#{f}", DESTINATION, :verbose => true) }

apps.each &install
