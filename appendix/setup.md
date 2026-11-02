# Setup

You need three things:

1. **GHC** — the compiler.
2. **GHCi** — the interactive REPL, included with GHC.
3. **Cabal** — the build tool and package manager, for later projects.

## Recommended: GHCup

GHCup installs and manages GHC, Cabal, Stack, and the Haskell Language Server.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

Follow the prompts. Then:

```bash
ghcup install ghc --set
ghcup install cabal --set
cabal update
```

Check:

```bash
ghc --version
cabal --version
ghci --version
```

## Editor

- **VS Code** with the Haskell extension.
- **Neovim** with `haskell-tools.nvim`.
- **Emacs** with `haskell-mode`.

The Haskell Language Server (HLS) gives type-on-hover, holes, case splitting, and imports. Install it with:

```bash
ghcup install hls
```

## GHCi commands to memorize

| Command | What it does |
|---|---|
| `:l Module` | Load a file. |
| `:r` | Reload the current file. |
| `:t expression` | Show the type. |
| `:info Name` | Show the definition and instances. |
| `:q` | Quit. |
| `:set +s` | Show timing and allocation. |
| `:type +v expression` | Show the type with `forall`s. |

## Docker fallback

If you cannot install GHC locally, use the official image:

```bash
docker run -it --rm -v "$PWD":/work -w /work haskell:9.2.4-slim ghci
```

Then load a file with `:l exercises/chapter-01.hs`.

The examples in this book target GHC 9.2 or newer. Most of them also work on GHC 8.10.

## First project

Once you finish Chapter 7, create a real project:

```bash
mkdir hello-haskell
cd hello-haskell
cabal init --interactive
cabal build
cabal repl
```

## The one rule

Every code example goes into a file, not only into GHCi. Files are testable; GHCi history is not.
