class Pqclens < Formula
  desc "Post-Quantum Cryptography vulnerability scanner agent"
  homepage "https://github.com/pqcrypto-ai/pqclens-releases"
  version "0.2.0"
  license :cannot_represent

  # Binaries are hosted in a separate public release repo
  # (pqcrypto-ai/pqclens-releases) so the source repo can stay private.
  # Each release uploads four tarballs — bump VERSION + sha256 below for
  # every new tag.
  on_macos do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-arm64.tar.gz"
      sha256 "9a357ac13c447c1b528f635933896deca747a51a16a3dbe114609e8589857b94"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-amd64.tar.gz"
      sha256 "e0f8478680b081f6918d1357d7289b7a03c4c007eb572e1bb7ba6fbe34d533ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-arm64.tar.gz"
      sha256 "df52656ca946fb6d81b33484eca9a043b57e1b2d72feabe8869199bfd9ddaa3b"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-amd64.tar.gz"
      sha256 "1aa9e73d104fe00837e650cfa4d829333da9d68c928e6f6d734f8c504afc769d"
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
