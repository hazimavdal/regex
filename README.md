# RegEx
This is a library for parsing and operating on formal regular expressions. The repository is divided into three modules:

- `regex`: A library for tokenizing and parsing regular expressions.
- `derivative`: A program for computing regular expression derivatives.
- `reverse`: A program for computing the reverse of regular expressions.

# Getting Started (Linux)

- Install `smlnj`: 
```
apt install smlnj
```

- Install [libgmp-dev](https://gmplib.org/): 

```
apt install libgmp-dev
```

- Install [mlton](http://mlton.org/): 

  - Download a release from [here](https://github.com/MLton/mlton/releases/tag/on-20201002-release)

  - Un-tar the downloaded file

  - Enter the untar-ed folder and run `make install`


- Run `make`. This will create two binaries, `bin/reverse` and `bin/derive`

## Acknowledgements
This implementation is based on Professor Timothy Ng's [lecture notes](http://people.cs.uchicago.edu/~timng/280/w20/). The utility file [util/check.sml](https://github.com/hazimavdal/regex/blob/master/util/check.sml) is borrowed from  Professor Adam Shaw's [CMSC 22100](http://people.cs.uchicago.edu/~adamshaw/cmsc22100-2018/index.html
).
