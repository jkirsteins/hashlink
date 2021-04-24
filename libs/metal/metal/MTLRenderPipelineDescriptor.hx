/**
    The MTLRenderPipelineDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:structInit
@:keep
class MTLRenderPipelineDescriptor
{
    public var vertexFunction(default, default) : MTLFunction;
    public var fragmentFunction(default, default) : MTLFunction;
}
