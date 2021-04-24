package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:hlNative("metal", "mtlcommandqueue_")
class MTLCommandQueue extends MetalResource<MTLCommandQueuePtr> {

    public function commandBuffer(): MTLCommandBuffer {
        return new MTLCommandBuffer( MTLCommandQueue.nativeCommandBuffer( this.ptr ) );
    }

    @:hlNative("metal", "mtlcommandqueue_commandBuffer")
    private static function nativeCommandBuffer( commandQueue: MTLCommandQueuePtr ): MTLCommandBufferPtr {
        return null;
    }
}
