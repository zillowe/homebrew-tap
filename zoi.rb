# Maintainer: ZilloweZ <zillowez@gmail.com>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.18.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "46b7cb446383c65d39c42c278ba3518693a51518376a7644498908a89c49748e"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "6f371899ecf1aa719e8ea77acc58bb6185e4ad5fe19c35348b5c2eec29260cfc"
    end

    on_linux do
      if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
        url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
        sha256 "b4f26543901ca7cdda360eb48210e5d56d30f041b0b716051c1be21d3b7384d5"
      end

      if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
        url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
        sha256 "75b5b2b648a5285c706b240a7bef032cc0accabe57b132b09cd91f48abf990a4"
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
