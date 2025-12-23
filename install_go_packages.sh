go install -u github.com/ketches/ktx@latest
go install github.com/okamyuji/wrk3@latest

# snitch - a netstat tui
# https://github.com/karol-broda/snitch
# no homebrew, go install doesn't work
curl -sSL https://raw.githubusercontent.com/karol-broda/snitch/master/install.sh | sh