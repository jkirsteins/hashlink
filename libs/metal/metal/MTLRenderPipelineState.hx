package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLRenderCommandEncoder)
@:hlNative("metal", "mtlrenderpipelinestate_")
class MTLRenderPipelineState extends MetalResource<MTLRenderPipelineStatePtr> {

}
