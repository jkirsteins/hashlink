package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:hlNative("metal", "mtlcommandqueue_")
class MTLCommandQueue extends MetalResource<MTLCommandQueuePtr> {

    public function commandBuffer(): MTLCommandBuffer {
        var bufferPtr = MTLCommandQueue.nativeCommandBuffer( this.ptr );
        var res = new MTLCommandBuffer( bufferPtr );
        return res;
    }

    @:hlNative("metal", "mtlcommandqueue_commandBuffer")
    private static function nativeCommandBuffer( commandQueue: MTLCommandQueuePtr ): MTLCommandBufferPtr {
        return null;
    }
}
