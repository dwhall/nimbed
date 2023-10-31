import std/volatile

type
  RegisterTypedesc = uint
  Register* = object
    address*: RegisterTypedesc
    resetValue*: RegisterTypedesc
    readableBits*: RegisterTypedesc
    writableBits*: RegisterTypedesc

type
  RCC_AHB1ENR_val* = RegisterTypedesc
  RCC_AHB1ENR_reg* = Register

const RCC_AHB1ENR = RCC_AHB1ENR_reg(
    address: 0x40023830,
    resetValue: 0x00000000,
    readableBits: 0x606410FF,
    writableBits: 0x606410FF)

proc read*(reg: static RCC_AHB1ENR_reg): RCC_AHB1ENR_val {.inline.} =
  volatileLoad(cast[ptr RCC_AHB1ENR_val](reg.address))

proc write*(reg: static RCC_AHB1ENR_reg, val: RCC_AHB1ENR_val) {.inline.} =
  volatileStore(cast[ptr RCC_AHB1ENR_val](reg.address), val)

proc main =
  var a = RCC_AHB1ENR.read()
  a += 1
  RCC_AHB1ENR.write(a)
  echo a

when isMainModule:
  main()
