class Openmax < Formula
  desc "Open Max: barebones high-performance agent harness TUI"
  homepage "https://github.com/Max17190/open-max"
  version "2026.11.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.5/openmax-aarch64-apple-darwin.tar.xz"
      sha256 "3483e9891c0763f79c1cf504a579cbf665c9911e699ad35c3036cd125e63a9b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.5/openmax-x86_64-apple-darwin.tar.xz"
      sha256 "1563aa3936d3fb53df0fcfc0c73aef5f83edfb53c985b2e26794c71c0bcfc6a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.5/openmax-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "742de4bbed30118cf4b123a9f2b5f311d92486e72937804bc878b3ea021cee98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.5/openmax-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d11ba1666d11cd2fc44bb32257e7e8420865a6b29df738440cfa2da1a167015b"
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
