package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLCommandBuffer)
@:hlNative("metal", "mtlrendercommandencoder_")
class MTLRenderCommandEncoder extends MetalResource<MTLRenderCommandEncoderPtr> {


}
