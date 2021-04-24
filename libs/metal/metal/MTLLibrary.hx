package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:hlNative("metal", "mtllibrary_")
class MTLLibrary extends MetalResource<MTLLibraryPtr> {
    public function newFunction(name: String): MTLFunction {
        return new MTLFunction(nativeNewFunction(ptr, @:privateAccess name.toUtf8()));
    }

    @:hlNative("metal", "mtllibrary_newFunction_name")
    private static function nativeNewFunction(ptr: MTLLibraryPtr, name: hl.Bytes): MTLFunctionPtr {
        return null;
    }
}
