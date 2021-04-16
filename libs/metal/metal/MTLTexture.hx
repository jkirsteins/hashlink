package metal;

@:allow(metal.Driver)
class MTLTexture {
    var ptr : MTLTexturePtr;

    private function new(ptr: MTLTexturePtr) {
        trace('Creating MTLTexture');
        this.ptr = ptr;
    }
}
