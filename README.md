---
format:
  html:
    embed-resources: true
---

# Homebrew Taps

Collection of various formulas.

Currently, this is mainly for various commercial solvers that do not have "proper" package installers:

	- COPT
	- MOSEK

## Installation Instructions

```sh
brew tap zeyuz35/homebrew-tap

# COPT
brew install copt
# MOSEK
brew install mosek
```

Follow post-installation messages to move licenses to correct folders, and also set up environment variables, if necessary.

## Programming Language APIs
Further integration with other programming languages will require other packages:

Python: 
```python
# copt - requries Python 3.13
uv pip install coptpy
# mosek
uv pip install mosek
```

R (no support for COPT yet):
```r
# Rmosek (DO NOT use the "official" Rmosek meta-package on CRAN!)

# Replace with the mosek version, currently 11.1
MSK_VER <- 11.1
BREW_PREFIX <- system("brew --prefix", intern = TRUE)
install.packages(
  pkgs = "Rmosek",
  repos = paste0("https://download.mosek.com/R/", MSK_VER),
  type = "source",
  configure.vars = paste0(
    "MSK_BINDIR=",
    BREW_PREFIX,
    "/bin ",
    "MSK_HEADERDIR=",
    BREW_PREFIX,
    "/include ",
    "MSK_LIB=mosek64 "
  )
)
```



