# Solutions

Each chapter has two forms:

- `chapter-XX.md` — the explanation, with the code and the reasoning.
- `ChapterXX.hs` — the runnable module used by `tests/Verify.hs`.

Try the exercise before reading the solution. The point is not the code; it is the shape of the reasoning.

Run the verification suite:

```bash
runghc -isolutions tests/Verify.hs
```

All 40 checks should print `ok` and finish with `All checks passed.`
