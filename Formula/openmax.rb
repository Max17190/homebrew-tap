class Openmax < Formula
  desc "Open Max: barebones high-performance agent harness TUI"
  homepage "https://github.com/Max17190/open-max"
  version "2026.11.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.6/openmax-aarch64-apple-darwin.tar.xz"
      sha256 "f7b82de3e16ad4264bb40f06f35b95d8ac3d406e423ddc2669638fe83d1da206"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.6/openmax-x86_64-apple-darwin.tar.xz"
      sha256 "049adba2d91e5d5b203530dacc303f70f0aeedfbeb6f047559e129cc66468a91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.6/openmax-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e84ac89f1bc6658b0242e7c0bbea24500799471d9baf9b24cc9f09c7042b2cee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.6/openmax-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba4e5e17e52d7374cf2eb151ea58899a4c18ad6010d530fe8d3a4cbc85319fc6"
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
