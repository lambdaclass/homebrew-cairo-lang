class CairoLangAT220 < Formula
  desc "Cairo Language v2.2.0"
  version "2.2.0"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "147204fd038332f0a731c99788930eb3a8e042142965b0aa9543e93d532e08df"
  license "Apache-2.0"

  def install
    current_user = ENV["USER"]
    ENV.prepend_path "PATH", "/Users/#{current_user}/.cargo/bin/"

    if !(File.file?("/Users/#{current_user}/.cargo/bin/rustup"))
      raise("rustup command not found, please run rustup-init to proceed...")
    end

    system("rustup override set stable")
    system("cargo build --all --release --manifest-path ./Cargo.toml")

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
end
