#!/usr/bin/env bash

# Get the releases using GitHub API
RELEASES=$(curl -s "https://api.github.com/repos/starkware-libs/cairo/releases")

for release in $(seq 0 $(($(echo $RELEASES | jq length) - 1))); do
	VERSION=$(echo $RELEASES | jq .[$release].tag_name | sed 's/"//g')
	DOWNLOAD_URL="https://github.com/starkware-libs/cairo/archive/refs/tags/$VERSION.tar.gz"

	curl -sLOJ $DOWNLOAD_URL

	SHA256_HASH=$(sha256sum "cairo-${VERSION#v}.tar.gz" | awk '{print $1}')

	rm cairo-${VERSION#v}.tar.gz

	FORMULA_FILE="cairo-lang@${VERSION#v}.rb"
	cat >"Formula/$FORMULA_FILE" <<EOL
class CairoLangAT$(echo $VERSION | tr -d 'v.-') < Formula
  desc "Cairo Language $VERSION"
  version "${VERSION#v}"
  depends_on "rust"
  depends_on "rustup"
  homepage "https://cairo-by-example.com/"
  url "$DOWNLOAD_URL"
  sha256 "$SHA256_HASH"
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
EOL

	echo "Created $FORMULA_FILE"
done

echo "All formula files created."
