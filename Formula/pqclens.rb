class Pqclens < Formula
  desc "Post-Quantum Cryptography vulnerability scanner agent"
  homepage "https://github.com/pqcrypto-ai/pqclens-releases"
  version "0.4.5"
  license :cannot_represent

  # Binaries are hosted in a separate public release repo
  # (pqcrypto-ai/pqclens-releases) so the source repo can stay private.
  # Each release uploads four tarballs — bump VERSION + sha256 below for
  # every new tag.
  on_macos do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-arm64.tar.gz"
      sha256 "fa783922516edd521be2a8bfd5fb87695a07b6983e3c9e55684544a579f3918d"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-darwin-amd64.tar.gz"
      sha256 "c8b2f694abfe8cf5b735e4c75c8c1ad621adc45e5c8925f7c5752a30a6a41e40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-arm64.tar.gz"
      sha256 "6e0bd97730bd37b198cabe9d5a890e0669aba33d0a4ea06331fa8f8792d550c4"
    end
    on_intel do
      url "https://github.com/pqcrypto-ai/pqclens-releases/releases/download/v#{version}/pqclens-v#{version}-linux-amd64.tar.gz"
      sha256 "620697140c712d04bcddfd7dc14f0dc8c50410aadf2ba0886ae1eb3782a3c777"
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
