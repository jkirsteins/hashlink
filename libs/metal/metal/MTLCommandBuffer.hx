package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLCommandQueue)
@:hlNative("metal", "mtlcommandbuffer_")
class MTLCommandBuffer extends MetalResource<MTLCommandBufferPtr> {
    public function renderCommandEncoderWithDescriptor(renderPassDescriptor: MTLRenderPassDescriptor): MTLRenderCommandEncoder {
        return new MTLRenderCommandEncoder( MTLCommandBuffer.nativeRenderCommandEncoderWithDescriptor( ptr, renderPassDescriptor ) );
    }

    public function commit() {
        MTLCommandBuffer.nativeCommit( ptr );
    }

    public function presentDrawable(drawable: CAMetalDrawable) {
        MTLCommandBuffer.nativePresentDrawable(
            ptr,
            @:privateAccess drawable.ptr );
    }

    @:hlNative("metal", "mtlcommandbuffer_commit")
    private static function nativeCommit(res: MTLCommandBufferPtr) {
    }

    @:hlNative("metal", "mtlcommandbuffer_presentDrawable")
    private static function nativePresentDrawable(res: MTLCommandBufferPtr, drawable: CAMetalDrawablePtr) {
    }

    @:hlNative("metal", "mtlcommandbuffer_renderCommandEncoder_descriptor")
    private static function nativeRenderCommandEncoderWithDescriptor(res: MTLCommandBufferPtr, proxyDescriptor: Dynamic): MTLRenderCommandEncoderPtr {
        return null;
    }
}
