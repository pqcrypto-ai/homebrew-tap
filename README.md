# homebrew-pqclens

Homebrew tap for the [PQClens](https://github.com/pqcrypto-ai) Post-Quantum
Cryptography vulnerability scanner agent.

## Install

```bash
brew install pqcrypto-ai/pqclens/pqclens
```

That's it — no `brew tap` step needed. Homebrew resolves the tap from the
slash-separated formula name on first install.

After install:

```bash
pqclens init                       # writes ~/.pqclens/config.toml
$EDITOR ~/.pqclens/config.toml     # set host + api_key
pqclens agent
```

## Supported platforms

| OS    | arm64 | amd64 |
|-------|:-----:|:-----:|
| macOS |  ✅   |  ✅   |
| Linux |  ✅   |  ✅   |

Binaries are hosted at
[pqcrypto-ai/pqclens-releases](https://github.com/pqcrypto-ai/pqclens-releases/releases).

## Updating

```bash
brew update
brew upgrade pqclens
```

## Releasing a new version (maintainers)

1. Tag and push the source repo: `git tag v0.2.0 && git push --tags`
2. `make build-all package-tarball` in the source repo to produce
   `bin/pqclens-v0.2.0-{darwin,linux}-{arm64,amd64}.tar.gz` and
   `bin/checksums.txt`
3. Create a release on `pqcrypto-ai/pqclens-releases` named `v0.2.0`,
   upload the four tarballs
4. In this repo, edit `Formula/pqclens.rb`:
   - Bump `version`
   - Replace the four `sha256` values from `checksums.txt`
5. `git commit -am "pqclens 0.2.0" && git push`
6. Verify: `brew update && brew upgrade pqclens && pqclens version`
