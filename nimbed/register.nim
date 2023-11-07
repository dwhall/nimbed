import std/bitops
import std/volatile


# Library level types
type
  RegisterTypedesc = uint32


# Device level types
type
  I2S_CTRLA_val* = distinct RegisterTypedesc
  I2S_CTRLA_ptr* = ptr I2S_CTRLA_val

const I2S_CTRLA = cast[I2S_CTRLA_ptr](0x40023830)

proc read*(reg: static I2S_CTRLA_ptr): I2S_CTRLA_val {.inline.} =
  volatileLoad(reg)

proc write*(reg: static I2S_CTRLA_ptr, val: I2S_CTRLA_val) {.inline.} =
  volatileStore(reg, val)

template modifyIt*(reg: static I2S_CTRLA_ptr, op: untyped): untyped =
  block:
    var it {.inject.} = reg.read()
    op
    reg.write(it)

# Reset value attr
func resetValue(r: I2S_CTRLA_ptr): I2S_CTRLA_val {.inline.} = 0x0000_0000.I2S_CTRLA_val

# Single-bit field accessors
func ENABLE*(v: I2S_CTRLA_val): RegisterTypedesc {.inline.} =
  v.RegisterTypedesc.bitsliced(1 .. 1)
func ENABLE*(v: static I2S_CTRLA_val): RegisterTypedesc {.inline.} =
  v.RegisterTypedesc.bitsliced(1 .. 1)

proc `ENABLE=`*(v: var I2S_CTRLA_val, val: SomeUnsignedInt) {.inline.} =
  var tmp = v.RegisterTypedesc
  tmp.clearMask(1 .. 1)
  tmp.setMask((val shl 1).masked(1 .. 1).RegisterTypedesc)
  v = tmp.I2S_CTRLA_val

# Multi-bit field accessors (made-up field)
func CKEN*(v: I2S_CTRLA_val): RegisterTypedesc {.inline.} =
  v.RegisterTypedesc.bitsliced(2 .. 3)

proc `CKEN=`*(v: var I2S_CTRLA_val, val: SomeUnsignedInt) {.inline.} =
  var tmp = v.RegisterTypedesc
  tmp.clearMask(2 .. 3)
  tmp.setMask((val shl 2).masked(2 .. 3).RegisterTypedesc)
  v = tmp.I2S_CTRLA_val


proc main =
  var r = I2S_CTRLA.resetValue
  var a = I2S_CTRLA.read().RegisterTypedesc
  a += r.RegisterTypedesc
  I2S_CTRLA.write(a.I2S_CTRLA_val)

  I2S_CTRLA.modifyIt:
    it.ENABLE = 1
  echo a

  I2S_CTRLA.modifyIt:
    it.ENABLE = 2   # exceeds bitfield
  echo a

  I2S_CTRLA.modifyIt:
    it.CKEN = 2
  echo a

  I2S_CTRLA.modifyIt:
    it.CKEN = 4   # exceeds bitfield
  echo a

when isMainModule:
  main()
