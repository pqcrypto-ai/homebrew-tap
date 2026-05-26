class Pqclens < Formula
  desc "Post-Quantum Cryptography vulnerability scanner agent"
  homepage "https://github.com/pqcrypto-ai/pqclens-releases"
  version "0.4.3"
  license :cannot_represent

  # Binaries are hosted in a separate public release repo
  # (pqcrypto-ai/pqclens-releases) so the source repo can stay private.
  # Each release uploads four tarballs — bump VERSION + sha256 below for
  # every new tag.
  on_macos do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-arm64.tar.gz"
      sha256 "adcef1e2af862afb11df7f1894a1dc0b08b5f37b299d016bf38b109af7a1bddf"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-amd64.tar.gz"
      sha256 "d89fd1bcc695a7708a6616051d42e9e5a296df7adf8da97d32f197975d1fc3db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-arm64.tar.gz"
      sha256 "a6e04b2635b228f42f8499f92b821914463e9690a11bc2f88e7fd85a109850b9"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-amd64.tar.gz"
      sha256 "669dde3460ab15cf0d34ccbb969133670bfb3465147d8b9c12e6cc395c7d0fd0"
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
