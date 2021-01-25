#!/usr/bin/env fish
# source it from fish


brew tap homebrew/cask-fonts
# don't use the -mono version, icons are off, too small
# and don't forget to configure iTerm to use the font
brew cask install font-meslo-nerd-font

brew tap jabley/homebrew-wrk2
brew install --HEAD wrk2

# shows k8s resource usage
brew tap robscott/tap
brew install kube-capacity

brew tap derailed/k9s
brew tap derailed/popeye

brew install popeye
brew install k9s

brew cask install aerial
brew cask install brooklyn
brew cask install transmission
brew cask install syntax-highlight
brew cask install imageoptim
brew cask install tinypng4mac
brew cask install iina
brew cask install insomnia
brew cask install skitch
brew cask install emby-server
brew cask install suspicious-package


for i in (cat brew-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test "(string length $i)" != "0"
		echo $i
		brew install (string trim $i)
	end

end
