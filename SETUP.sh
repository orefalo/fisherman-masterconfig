

# install brew if not installed
if test ! -x (which brew)
    /bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
end



helm plugin install https://github.com/futuresimple/helm-secrets
helm plugin install https://github.com/databus23/helm-diff --version master 
# like npm-check but for charts
helm plugin install https://github.com/fabmation-gmbh/helm-whatup

# terraform prettyfier/colorizer
go get -u github.com/dmlittle/scenery

