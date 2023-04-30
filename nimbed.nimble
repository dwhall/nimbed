# Package

version       = "0.1.0"
author        = "!!Dean"
description   = "Nim for embedded systems"
license       = "MIT"
srcDir        = "nimbed"

bin           = @["register", "gpio",]

# Dependencies

requires "nim >= 1.6.10"
