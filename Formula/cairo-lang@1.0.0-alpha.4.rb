class CairoLangAT100Alpha4 < Formula
  desc "Cairo Language v1.0.0-alpha.4"
  version "1.0.0-alpha.4"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v1.0.0-alpha.4.tar.gz"
  sha256 "3fb7e86e2fc88ef57e7bf9178d5e8c9272f558c8c9fb5d2ebea18b327b661e4b"
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
