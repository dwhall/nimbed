import std / options

# TODO: import pkg / core
import core

type
  # The following type-state implementation was adapted
  # from ElegentBeef: https://forum.nim-lang.org/t/9976#65966

  Direction = enum
    Input, Output

  GpioConfig[
    TEnabled: static bool,
    TDirection: static Option[Direction]
  ] = distinct NimbedConfig

# GpioConfig's type states
type GpioConfig_Init = GpioConfig[false, none(Direction)]
type GpioConfig_Enabled = GpioConfig[true, none(Direction)]

# Prevent copies of the resource at compile-time
proc `=copy`[T, Y](config: var GpioConfig[T, Y], src: GpioConfig[T, Y]) {.error.}

proc initGpioConfig(): GpioConfig_Init =
  discard

proc enable(cfg: sink GpioConfig_Init): GpioConfig_Enabled =
  result = (typeof result)(cfg)

proc disable[T](cfg: sink GpioConfig[true, T]): GpioConfig_Init =
  result = (typeof result)(cfg)

proc setDirection(cfg: sink GpioConfig_Enabled, direction: static Direction): GpioConfig[true, some(direction)] =
  result = (typeof result)(cfg)

proc main() =
  ## The following code demonstrates the ownership of one GpioConfig
  ## passed from one variable to the next and how the GpioConfig type state (above)
  ## intentionally prohibits certain procedures from compiling using Nim's type system.
  let initd = initGpioConfig()
  assert not compiles initd.disable()
  assert not compiles initd.setDirection(Input)
  assert not compiles initd.setDirection(Output)

  let enabled = initd.enable()
#  let enabled2 = initd.enable()   # FAIL
  assert not compiles initd.setDirection(Input)
  assert not compiles enabled.enable()

  let directed = enabled.setDirection(Input)
#  let disabled = enabled.disable()   # FAIL

  let disabled = directed.disable()
  assert not compiles disabled.disable()
  assert not compiles disabled.setDirection(Input)
  assert not compiles disabled.setDirection(Output)

  let reenabled = disabled.enable()
  assert not compiles disabled.disable()
  assert not compiles disabled.setDirection(Input)
  assert not compiles disabled.setDirection(Output)
  assert not compiles reenabled.enable()
#  assert not compiles reenabled.setDirection(Input)
#  assert not compiles reenabled.setDirection(Output)


when isMainModule:
  main()
