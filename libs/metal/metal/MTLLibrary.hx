package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:hlNative("metal", "mtllibrary_")
class MTLLibrary {
    var ptr : MTLLibraryPtr;

    private function new(ptr: MTLLibraryPtr) {
        this.ptr = ptr;
    }
}
