# homebrew-tap

Homebrew tap for [PQClens](https://github.com/pqcrypto-ai) tooling. A single
multi-formula tap so all PQClens CLIs share the same `brew tap` and the same
`brew upgrade` cycle.

## Available formulas

| Formula | Install command | Description |
|---------|-----------------|-------------|
| `pqclens` | `brew install pqcrypto-ai/tap/pqclens` | PQC vulnerability scanner agent |

More formulas (e.g. `pqclens-server`) will be added here as they ship —
each backed by its own `<name>-releases` repo so per-project release
lifecycles stay independent.

## Quick start (pqclens agent)

```bash
brew install pqcrypto-ai/tap/pqclens
pqclens init                       # writes ~/.pqclens/config.toml from template
$EDITOR ~/.pqclens/config.toml     # set host + api_key
pqclens agent
```

No separate `brew tap` step is needed — Homebrew resolves the tap from the
slash-separated formula reference on first install.

## Supported platforms

| OS    | arm64 | amd64 |
|-------|:-----:|:-----:|
| macOS |  ✅   |  ✅   |
| Linux |  ✅   |  ✅   |

Binaries are hosted in per-project public release repos
(e.g. [pqclens-releases](https://github.com/pqcrypto-ai/pqclens-releases/releases))
so the tool source code can stay private.

## Updating

```bash
brew update
brew upgrade pqclens
```

## Releasing a new version (maintainers)

The pqclens release flow is documented end-to-end in the source repo's
`README.md` → "Release Flow" section. Brief recap:

1. **Source repo** (`pqcrypto-ai/pqclens`):
   `git tag v0.2.0 && git push --tags && make clean build-all package-tarball`
   → produces `bin/pqclens-v0.2.0-{darwin,linux}-{arm64,amd64}.tar.gz` and
   `bin/checksums.txt`
2. **Release repo** (`pqcrypto-ai/pqclens-releases`):
   create release `v0.2.0`, upload the four tarballs.
3. **This tap repo**: edit `Formula/pqclens.rb` — bump `version`, replace
   the four `sha256` values from `checksums.txt`, commit, push.
4. Verify: `brew update && brew upgrade pqclens && pqclens version`

## Adding a new formula to this tap

1. Create `pqcrypto-ai/<name>-releases` (public, holds the binary tarballs).
2. Drop `Formula/<name>.rb` here (Class name in CamelCase: `MyTool`,
   filename in lowercase-with-dashes).
3. Bump version + sha256 on each release the same way `pqclens.rb` does.
4. Users install via `brew install pqcrypto-ai/tap/<name>`.

## History

Renamed from `pqcrypto-ai/homebrew-pqclens` on 2026-04-24 to a generic
multi-formula tap. GitHub redirects the old URL so `brew tap` users
already on the previous name keep working.
