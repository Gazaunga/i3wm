#!/usr/bin/env ruby

require 'fileutils'

DESTINATION = "#{Dir.home}/"

apps = %w[
  mpd
  ncmpcpp
  zsh
  dunst
  i3-gaps-git
  polybar-git
  qutebrowser
  firefox
  rxvt-unicode
  emacs
  feh
  youtube-dl-git
  i3lock-color
  compton-git
  zathura
  zathura-pdf-mupdf
  newsboat-git
]

install = ->app{ `trizen -Syu --noconfirm #{app}` }

def grab_wallpaper
status = system("git clone https://github.com/Gazaunga/.wallpapers ~/.wallpapers")
puts status ? "Success" : "Failed"
end

def grab_fonts
status = system("git clone https://github.com/Gazaunga/.fonts ~/.fonts")
puts status ? "Success" : "Failed"
`fc-cache -fv`
end

def make_spacemacs
status = system("git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d")
puts status ? "Success" : "Failed" 
end

## MAIN ##
grab_wallpaper
grab_fonts
make_spacemacs
Dir.glob("#{Dir.home}/i3wm/.", File::FNM_DOTMATCH).each { |f| FileUtils.cp_r("#{f}", DESTINATION, :verbose => true) }

apps.each &install
