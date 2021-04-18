package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:hlNative("metal", "mtltexture_")
class MTLTexture {
    var ptr : MTLTexturePtr;

    private function new(ptr: MTLTexturePtr) {
        this.ptr = ptr;
    }

    public function replace(region: MTLRegion, mipmapLevel: Int, bytes: hl.Bytes, bytesPerRow: Int)
    {
        nativeReplace(ptr, region, mipmapLevel, bytes, bytesPerRow);
    }

    @:hlNative("metal","mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow")
    private static function nativeReplace(ptr: MTLTexturePtr, region: Dynamic, mipmapLevel: Int, bytes: hl.Bytes, bytesPerRow: Int)
    {
    }
}
