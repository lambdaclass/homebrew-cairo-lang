class CairoLangAT100alpha7 < Formula
  desc "Cairo Language v1.0.0-alpha.7"
  version "1.0.0-alpha.7"
  depends_on "rust"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v1.0.0-alpha.7.tar.gz"
  sha256 "be01afc74d2bfb07096ec7b7618e3fee132cd86dcbac1e0361e3d82ee5e1546e"
  license "Apache-2.0"

  def install
    if !(File.file?("/opt/homebrew/bin/rustc") || File.file?("/Users/#{current_user}/.cargo/bin/rustc"))
      raise("Rust compiler not installed, please install it first!")
    end

    current_user = ENV["USER"]
    ENV.prepend_path "PATH", "/Users/#{current_user}/.cargo/bin/"

    if !(File.file?("/Users/#{current_user}/.cargo/bin/rustup"))
      puts "Rust compiler found but rustup, installing..."
      system("rustup-init -qy")
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
