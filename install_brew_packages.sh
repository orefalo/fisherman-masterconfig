#!/usr/bin/env fish
# source it from fish

brew tap homebrew/cask-fonts
# don't use the -mono version, icons are off, too small
# and don't forget to configure iTerm to use the font
brew install --cask font-meslo-lg-nerd-font
brew install --cask iina
brew install --cask suspicious-package
brew install --cask syntax-highlight
brew install --cask aerial
brew install --cask aural
brew install --cask sloth

# load tester
# oha is much much better
# brew tap jabley/homebrew-wrk2
# brew install --HEAD wrk2

# shows k8s resource usage
# brew tap robscott/tap
# brew install kube-capacity

# brew tap tinygo-org/tools
# brew install tinygo

# brew tap derailed/k9s
# brew install k9s

# brew tap derailed/popeye
# brew install popeye

# brew tap nats-io/nats-tools
# brew install nats-io/nats-tools/nats

#brew tap aws/tap
#brew install aws-sam-cli

# a great DNS client
# brew tap natesales/repo https://github.com/natesales/repo
# brew install natesales/repo/q

for i in (cat brew-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test -n "$i"
		echo $i
		brew install (string trim $i)
	end

end
