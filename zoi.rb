# Maintainer: ZilloweZ <zillowez@gmail.com>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.17.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "41f71212d0db7a5a34f9bbe4f60895f381d1eb989cfe662297198bec494a34b6"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "08a13b9695c0c35a9bda2ebfe3561b6255f04880c3cf0439cb6837919c6e4204"
    end

    on_linux do
      if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
        url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
        sha256 "0821d83474de88724e5617360f9e4328f1cf76e58a7988e47951308e6c65d144"
      end

      if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
        url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
        sha256 "688a959443718f171e340c8466852ea2d0d2ec38887a42899f3ea8590c4c8b77"
      end
    end

  end

  def install
    bin.install "zoi"
    (bash_completion/"zoi").write `#{bin}/zoi generate-completions bash`
    (zsh_completion/"_zoi").write `#{bin}/zoi generate-completions zsh`
    (fish_completion/"zoi.fish").write `#{bin}/zoi generate-completions fish`
  end
end
