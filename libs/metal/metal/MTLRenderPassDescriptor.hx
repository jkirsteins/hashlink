/**
    The MTLRenderPassDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:structInit
@:keep
class MTLRenderPassDescriptor
{
    public var colorAttachments = new hl.NativeArray<MTLRenderPassColorAttachmentDescriptor>(0);

    public function new() {

    }
}
