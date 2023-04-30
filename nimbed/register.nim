import std / volatile

# TODO: import pkg / core
import core

type
  RegisterType* = uint8 | uint16 | uint32 # | uint64
  RegisterPtr* = ptr RegisterType  # ptr uint8 | ptr uint16 | ptr uint32 | ptr uint64

  RegisterAttr = enum
    Readable,
    Writable
  RegisterAttrs = set[RegisterAttr]

  RegisterConfig[
    TAddress: static RegisterPtr,
    TReadWriteAttr: static RegisterAttrs,
  ] = distinct NimbedConfig

proc initRegister*(address: static RegisterPtr, rwAttrs: static RegisterAttrs): RegisterConfig[address, rwAttrs] =
  discard

proc load*(cfg: RegisterConfig): RegisterType =
  cfg.TAddress.volatileLoad()

proc store*[T](cfg: RegisterConfig, val: T) =
  cfg.TAddress.volatileStore(val)


when isMainModule:
  const PORTA = initRegister(cast[ptr uint8](0x0100), {Readable, Writable})     # Compiles, but it's verbose/ugly
  let a = PORTA.load()
  PORTA.store(a+1)
