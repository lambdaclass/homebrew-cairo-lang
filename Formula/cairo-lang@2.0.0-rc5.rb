class CairoLangAT200Rc5 < Formula
  desc "Cairo Language v2.0.0-rc5"
  version "2.0.0-rc5"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "https://github.com/starkware-libs/cairo/archive/refs/tags/v2.0.0-rc5.tar.gz"
  sha256 "c9b59720338c255399f83ff9384a77dae5841262279eb136c243eb9fa6f61139"
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
