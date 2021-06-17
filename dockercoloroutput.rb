class Dockercoloroutput < Formula
  desc "This package allows to colorize the docker output."
  homepage "https://github.com/devemio/docker-color-output"
  url "https://github.com/devemio/docker-color-output/archive/refs/tags/v2.0.0.tar.gz"
  version "v2.0.0"
  sha256 "f0585ec1ae03608215bcb389eb6ce4bd34f5c4409a190f80b8d59140b353933a"
  license "MIT"

  depends_on "go" => :build
  depends_on "cmake" => :build

  def install
    system "make"
    mv "bin/dco-darwin-amd64", "docker-color-output"
    bin.install "docker-color-output"
  end

  test do
    system "false"
  end
end


