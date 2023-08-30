class CairoLang < Formula
  desc "Cairo language installation"
  version "2.2.0"
  depends_on "rust"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v#{version}.tar.gz"
  sha256 "147204fd038332f0a731c99788930eb3a8e042142965b0aa9543e93d532e08df"
  license "Apache-2.0"

  def install
    if File.file?("/opt/homebrew/bin/rustc") || File.file?("/Users/$USER/.cargo/bin/rustc")
      raise("Rust compiler not installed, please install it first!")
    end

    print("Detected Rust installation \n")

    current_user = ENV["USER"]
    ENV.prepend_path "PATH", "/Users/#{current_user}/.cargo/bin/"

    print(`rustup override set stable`)
    print(`cargo build --all --release --manifest-path ./Cargo.toml`)

    prefix.install Dir["./corelib/"]
    bin.install "./target/release/cairo-compile"
    bin.install "./target/release/cairo-format"
    bin.install "./target/release/cairo-language-server"
    bin.install "./target/release/cairo-run"
    bin.install "./target/release/cairo-test"
    bin.install "./target/release/sierra-compile"
    bin.install "./target/release/starknet-compile"
    bin.install "./target/release/starknet-sierra-compile"
  end

  test do
    system "#{bin}/cairo-run", "-V"
  end
end
