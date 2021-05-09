package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:allow(metal.CAMetalDrawable)
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

    public function debugSave(path: String)
    {
        nativeDebugSave(ptr, @:privateAccess path.toUtf8());
    }

    @:hlNative("metal","mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow")
    private static function nativeReplace(ptr: MTLTexturePtr, region: Dynamic, mipmapLevel: Int, bytes: hl.Bytes, bytesPerRow: Int)
    {
    }

    @:hlNative("metal","mtltexture_debug_save")
    private static function nativeDebugSave(ptr: MTLTexturePtr, path: hl.Bytes)
    {
    }
}
