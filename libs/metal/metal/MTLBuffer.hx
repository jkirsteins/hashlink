package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLRenderCommandEncoder)
@:hlNative("metal", "mtlbuffer_")
class MTLBuffer extends MetalResource<MTLBufferPtr> {

    public function contentsMemcpy(
        data: hl.Bytes,
        offset: Int,
        size: Int) {
        nativeContentsMemcpy(
            ptr,
            data,
            offset,
            size);
    }

    public function getLength() {
        return nativeGetLength(ptr);
    }

    @:hlNative("metal","mtlbuffer_length")
	static function nativeGetLength(
        buffer : MTLBufferPtr): Int {
            return 0;
    }

    @:hlNative("metal","mtlbuffer_contents_memcpy")
	static function nativeContentsMemcpy(
        buffer : MTLBufferPtr,
        data: hl.Bytes,
        offset: Int,
        size: Int) {
    }
}
