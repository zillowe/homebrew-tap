# Maintainer: ZilloweZ <zillowez@proton.me>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.29.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "47f157cbd26de8215b9b321a9f0a817b21f5a3062247dee60b613ad4d62da978"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "6e61b1f10e7c7ea7a05da0191284e4f41f5e6900503de67b78546c6f83e37c37"
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
      sha256 "c136f8cb7ffca2b56bebbb24aa020f2aec7399ab25f7e84085ae7cdd269f1dfa"
    end

    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
      sha256 "71089c07a770045c78b6aba4aad127ff693b22d9b45eea13bad670108775ae56"
    end
  end

  resource "zoi-man-1" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi.1"
    sha256 "0e5f5873c4be9e4af726428887471e3e36ecade4182e8f3dc46defbda63e6a4b"
  end

  resource "zoi-rs-man-3" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-rs.3"
    sha256 "73e742e9dcbcfb659f7b86a46dc9bc65f0ea2aaa7d5d99d7376a3f16e4665db0"
  end

  resource "zoi-lua-man-5" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-lua.5"
    sha256 "49bacbd673639f2137a5e8e187fa50592df60fb7f50d0f582b7dcc859b797a00"
  end

  def install
    bin.install "zoi"
    (bash_completion/"zoi").write `#{bin}/zoi generate-completions bash`
    (zsh_completion/"_zoi").write `#{bin}/zoi generate-completions zsh`
    (fish_completion/"zoi.fish").write `#{bin}/zoi generate-completions fish`

    man1.install resource("zoi-man-1")
    man3.install resource("zoi-rs-man-3")
    man5.install resource("zoi-lua-man-5")
  end

  test do
    assert_match "zoi", shell_output("#{bin}/zoi --version")
  end
end
