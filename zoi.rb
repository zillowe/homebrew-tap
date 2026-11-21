# Maintainer: ZilloweZ <zillowez@proton.me>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.29.15"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "6f2e87dc694c24c8b9069aa6bd57612ba27936b7e8bf8b175b5e21b0c8eefea5"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "2d8dd73d00da15517a4057410d3893c7a2d1883b5b8c6d7674c3752733e38354"
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
      sha256 "42834c5efe5b536dc58a537ce0159ce67d00dc2f797968f84c2ec641d002dbb4"
    end

    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
      sha256 "863d1221b3e66df558738ba4e0927d32de3f4961f58fce67ffa620eee9e261f3"
    end
  end

  resource "zoi-man-1" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi.1"
    sha256 "2ea72b94bffc6f1efcce1450f59256b6c90836ca105431b597175dea8243014d"
  end

  resource "zoi-rs-man-3" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-rs.3"
    sha256 "64fd21e3d32aa6fd932622bb612f332de3d1a56803c23bb8ced92114a60f00ab"
  end

  resource "zoi-lua-man-5" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-lua.5"
    sha256 "b8ae8cdcedf234871dbd56bbe6d1272abfcf279dfa9a3b252fb10ac88aa2ad63"
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
