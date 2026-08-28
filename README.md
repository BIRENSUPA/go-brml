# Go Bindings for the Birentech Management Library (BRML)

```
go get github.com/BIRENSUPA/go-brml
```

## Overview

This repository provides Go bindings for the BRML

At present, these bindings are only supported on Linux.

## Requirements

1. Biren GPU Driver >= 1.2.2

## Example

```
go run example/example.go
```

## Generate bindings

1. Install c-for-go follow the repo (https://github.com/xlab/c-for-go)
2. run `make gen`


**Note:** The make process modifies `brml.h` in that it translates any opaque
types defined by `brml.h` into something more recognizable by `cgo`.

For example:

```diff
-typedef struct brmlDevice_st* brmlDevice_t;
+typedef struct
+{
+   struct brmlDevice_st* handle;
+} brmlDevice_t;
```

The two statements are semantically equivalent in terms of how they are laid
out in memory, but `cgo` will only generate a unique type for `brmlDevice_t`
when expressed as the latter. When building the bindings we first update
`brml.h` using `sed`, and then run `c-for-go` over it.