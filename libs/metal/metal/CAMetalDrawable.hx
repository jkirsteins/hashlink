package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:hlNative("metal", "cametaldrawable_")
class CAMetalDrawable extends MetalResource<CAMetalDrawablePtr> {
    public function getTexture(): MTLTexture {
        return new MTLTexture( CAMetalDrawable.nativeGetTexture( ptr ) );
    }

    @:hlNative("metal", "cametaldrawable_getTexture")
    private static function nativeGetTexture(drawable: CAMetalDrawablePtr): MTLTexturePtr {
        return null;
    }
}
