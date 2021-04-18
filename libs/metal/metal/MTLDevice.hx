package metal;

import metal.NSInteger;
import metal.NSUInteger;
import haxe.Int64;

@:allow(metal.Driver)
@:hlNative("metal", "mtldevice_")
class MTLDevice {
    var ptr : MTLDevicePtr;

    private function new(ptr: MTLDevicePtr) {
        this.ptr = ptr;
    }

    public function newLibraryFromSource(source: String): MTLLibrary
    {
        return new MTLLibrary( MTLDevice.nativeNewLibraryFromSource( ptr, @:privateAccess source.toUtf8() ) );
    }

    @:hlNative("metal", "mtldevice_newLibrary_source")
    private static function nativeNewLibraryFromSource(device: MTLDevicePtr, source: hl.Bytes): MTLLibraryPtr {
        return null;
    }
}
