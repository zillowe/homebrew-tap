# Maintainer: ZilloweZ <zillowez@proton.me>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.29.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "9861e1e59154245886ae843e2e1371410e54cc2032dfb94f8893b92cb9fd8a5f"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "5ccd4ba0ca58d30626f6611c7263702d81d049fffee02941cd69d3a6cd31f0ac"
    end
  end

  on_linux do
    if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
      sha256 "21545d77730dc829056ab7e72ac2da91d36de828519d879c85cb7cc73697efa8"
    end

    if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
      sha256 "a1417010d36ef662f021abb744c48f4d369d57c9ad6e30dc3dcab00a9d2127c0"
    end
  end

  resource "zoi-man-1" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi.1"
    sha256 "19b12808fb9845dd5dc58c5cc2e919a6d3746d73d727888a248c17b0d6c13f06"
  end

  resource "zoi-rs-man-3" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-rs.3"
    sha256 "c32b5e8ae528da2d24cc9f51541fd35e9d0c52b3c99a162bfa135212b95d2c36"
  end

  resource "zoi-lua-man-5" do
    url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-lua.5"
    sha256 "793555f88b6c9f01248142f064b7c40c99d01aed9c5f1cf57bc8d70c903381c9"
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
