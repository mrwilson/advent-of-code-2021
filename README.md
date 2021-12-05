# advent-of-code-2021

![Tests](https://github.com/mrwilson/advent-of-code-2021/actions/workflows/tests.yml/badge.svg)

Advent of SQL was not enough. This year, it's ...

👽 **Jadvent of Qode** 👽

So, what's here?

- Each day's puzzles live under the corresponding numeric directory `nn/`
- Directory numbers are zero-padded because numeric order is important to me
- Each directory will probably have:
  - `day_nn.jq` (the solution)
  - `day_nn_test.jq` (the unit tests)
  - `input.txt` from the AoC site
    
- Teeny-tiny test/matcher framework that lives in `testing.jq`. I'll probably pull this out as a separate module once AoC is over called "jamqrest"
- `00/` is the testing spike and corresponds to Day 1 of AoC 2019

```
$ ./run.sh

Usage: run.sh [-d (day)] [-p (part)] [-t (tests only)]
```
