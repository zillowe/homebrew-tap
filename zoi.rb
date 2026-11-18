# Maintainer: ZilloweZ <zillowez@proton.me>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.29.14"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "12dc7498a8d92701d90e516c01ecce3d1310ec558995d6f04ffb5b18c29bca44"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "0ef3b298a2383fc0247f539a10e5f7a0d698665b25037b702fedee5289a81d5b"
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
      sha256 "d744e1673502aa0b50ccefb0cb2c3b0a86cd32048b7ec449846a23def149aa1f"
    end

    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
      sha256 "5440060916464eccf873e6bf8835e7d753c54fd1fde486550ff522942f16c552"
    end
  end

  resource "zoi-man-1" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi.1"
    sha256 "0e58644e88f6cc5eee4ed9f8105919b4b29d1e35bd3cd4a3e62e41b504e28bb4"
  end

  resource "zoi-rs-man-3" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-rs.3"
    sha256 "8c9dc2f044e52de9d982e570052cf1275658072b78c9fe7a5a9651f5863a1620"
  end

  resource "zoi-lua-man-5" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-lua.5"
    sha256 "5a4e6c5caf870481723be0fb9afbf10874d9f9664eec669e27bf6d7a6426a6a8"
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
