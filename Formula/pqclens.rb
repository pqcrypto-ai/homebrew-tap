class Pqclens < Formula
  desc "Post-Quantum Cryptography vulnerability scanner agent"
  homepage "https://github.com/pqcrypto-ai/pqclens-releases"
  version "0.4.2"
  license :cannot_represent

  # Binaries are hosted in a separate public release repo
  # (pqcrypto-ai/pqclens-releases) so the source repo can stay private.
  # Each release uploads four tarballs — bump VERSION + sha256 below for
  # every new tag.
  on_macos do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-arm64.tar.gz"
      sha256 "5455fbbaee08339aa9ad587707be263aad6ea5b49203a190e9e8d470dbea5b35"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-amd64.tar.gz"
      sha256 "decd0af9fa3e44f55e915d517ccc8d943d41a961b0df6ad7a613a2039f8ee185"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-arm64.tar.gz"
      sha256 "8e1c020fba09094aa533358a90dfb0663378767def3b5db0ae96aed15b647d9d"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-amd64.tar.gz"
      sha256 "0a4da44d9693b51d8eb6e84e48dc7963da2fd5dea10b128265c0714b5a4a90e2"
    end
  end

  # nmap is the primary host-discovery tool the agent shells out to. The
  # agent gracefully degrades if it's missing, but auto-installing it gives
  # users the full feature set out of the box.
  depends_on "nmap"
  depends_on "openssl@3"

  def install
    bin.install "pqclens"
    generate_completions_from_executable(bin/"pqclens", "completion")
  end

  def caveats
    <<~EOS
      To set up your PQClens agent for the first time:

        pqclens init                  # writes ~/.pqclens/config.toml from template
        $EDITOR ~/.pqclens/config.toml  # set the server host and api_key
        pqclens agent                 # start scanning

      Logs go to stdout/stderr — pipe to your favourite logger or run inside
      a launchd/systemd unit if you want a persistent daemon.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pqclens version")
  end
end
