package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLCommandQueue)
@:hlNative("metal", "mtlcommandbuffer_")
class MTLCommandBuffer extends MetalResource<MTLCommandBufferPtr> {

}
