class Openmax < Formula
  desc "Open Max: barebones high-performance agent harness TUI"
  homepage "https://github.com/Max17190/open-max"
  version "2026.11.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.3/openmax-aarch64-apple-darwin.tar.xz"
      sha256 "9c9c952cda165df620529b0360dc522130602a4267f283f0bb96ec41703e575b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.3/openmax-x86_64-apple-darwin.tar.xz"
      sha256 "f0426785e02039c1d5f4b1a0a054001c1028900d7745a243020bad18fa255513"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.3/openmax-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "629d0ef45f4357dd11322bb1873821c4426b15572d4d6b4654b27696035a1df9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Max17190/open-max/releases/download/v2026.11.3/openmax-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "afdf01e9fa7ccaff96d9d83797c642f76a116d2858fc6fb2f26c6b29a7568805"
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
