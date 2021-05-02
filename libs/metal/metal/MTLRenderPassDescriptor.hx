/**
    The MTLRenderPassDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

import metal.MTLRenderPassDepthAttachmentDescriptor;

@:structInit
@:keep
class MTLRenderPassDescriptor
{
    public var colorAttachments = new hl.NativeArray<MTLRenderPassColorAttachmentDescriptor>(0);
    public var depthAttachment: MTLRenderPassDepthAttachmentDescriptor = null;
    public var stencilAttachment: MTLRenderPassStencilAttachmentDescriptor = null;

    public function new() {

    }
}
