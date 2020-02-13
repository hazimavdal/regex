# Derivative

This module computes the [Brzozowski Derivative](https://en.wikipedia.org/wiki/Brzozowski_derivative) of formal regular expressions.

## Usage

The module takes three arguments.

- `-e`: the regular expression to compute the derivative of
- `-x`: the symbol to compute the derivative with respect to
-`-n`: the order of the derivative to compute. `-n 0` will return the input expression.
-`-u`: lists all the unique Brzozowski derivatives for the given expression. If this option is set then `-n` is ignored.

## Building

The `Makefile` requires the [MLton](http://mlton.org/) tool. Running `make` inside this folder will produce a stand-alone binary `../bin/derive`.

