class CairoLangAT110Rc0 < Formula
  desc "Cairo Language v1.1.0-rc0"
  version "1.1.0-rc0"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v1.1.0-rc0.tar.gz"
  sha256 "2b404a029cf0bf3d6fc7bf8f15a6eb352e282a59cb52f45b37cae7676e40c69c"
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
