/**
    The MTLRenderPassColorAttachmentDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:structInit
@:keep
class MTLRenderPassColorAttachmentDescriptor extends MTLRenderPassAttachmentDescriptor
{
    public var clearColor: MTLClearColor;
}
