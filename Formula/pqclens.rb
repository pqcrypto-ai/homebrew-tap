class Pqclens < Formula
  desc "Post-Quantum Cryptography vulnerability scanner agent"
  homepage "https://github.com/pqcrypto-ai/pqclens-releases"
  version "0.4.7"
  license :cannot_represent

  # Binaries are hosted in a separate public release repo
  # (pqcrypto-ai/pqclens-releases) so the source repo can stay private.
  # Each release uploads four tarballs — bump VERSION + sha256 below for
  # every new tag.
  on_macos do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-arm64.tar.gz"
      sha256 "9596a14d996f7e0360fd456611658a53456bd21d2f3d8f9904a8180a169ec251"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-amd64.tar.gz"
      sha256 "0e52989d8cd0f4b83049ea646ca411365e67a3f4e3c4e8879c92922ee55c928a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-arm64.tar.gz"
      sha256 "fe861ef69c7887af630e2552c2ff2cd854883e944372cb34f3a20b420252733d"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-amd64.tar.gz"
      sha256 "da9f6446b8f7b6a12d5ec8f37041286e8fcaafa588966cfe1c44554be76b8e6c"
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
