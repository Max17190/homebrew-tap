class Openmax < Formula
  desc "Open Max: barebones high-performance agent harness TUI"
  homepage "https://github.com/Max17190/open-max"
  version "2026.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.0/openmax-aarch64-apple-darwin.tar.xz"
      sha256 "737a5d8872d954920e4b1c95d07f2ab2b40fa290fcb40d2ccc05d1b47e3c45a1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.0/openmax-x86_64-apple-darwin.tar.xz"
      sha256 "e7f0865c99b74d7c2c0718f0e87bb11d5f3bd3e3467b1da8391a0d2136a3f960"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.0/openmax-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f05e62f59933b7eba8a02ee3d8f63c31c5df30b419cc1892dfad22e6a112d74"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.0/openmax-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9243d6e68195e54c84a473632e7d369bf090d639a6de8dd15fdc72df66bbcfe3"
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
