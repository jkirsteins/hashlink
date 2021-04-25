package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLCommandQueue)
@:hlNative("metal", "mtlcommandbuffer_")
class MTLCommandBuffer extends MetalResource<MTLCommandBufferPtr> {
    public function renderCommandEncoderWithDescriptor(renderPassDescriptor: MTLRenderPassDescriptor): MTLRenderCommandEncoder {
        return new MTLRenderCommandEncoder( MTLCommandBuffer.nativeRenderCommandEncoderWithDescriptor( ptr, renderPassDescriptor ) );
    }

    @:hlNative("metal", "mtlcommandbuffer_renderCommandEncoder_descriptor")
    private static function nativeRenderCommandEncoderWithDescriptor(res: MTLCommandBufferPtr, proxyDescriptor: Dynamic): MTLRenderCommandEncoderPtr {
        return null;
    }
}
