class Openmax < Formula
  desc "Open Max: barebones high-performance agent harness TUI"
  homepage "https://github.com/Max17190/open-max"
  version "2026.11.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.4/openmax-aarch64-apple-darwin.tar.xz"
      sha256 "2f1eab4604f5b4763edcfb904a50e2a34b980a460ff60f67785ffbf52a62124f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.4/openmax-x86_64-apple-darwin.tar.xz"
      sha256 "8e2d4491b2646aa55b2d22c49b36556f7b76b25d3e38e84967f36de894441168"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.4/openmax-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "555c6e3ddaaca0c0a29c7ceb62af080cc782aa8c239a7cc9c833b3c3d71a2bfc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.4/openmax-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8b2405ca663e2cd2a10278179a2298821f937f8804abcfff82752eeb1b1bd446"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "openmax"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "openmax"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "openmax"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "openmax"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
