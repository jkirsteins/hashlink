/**
    The MTLRenderPassStencilAttachmentDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:structInit
@:keep
class MTLRenderPassStencilAttachmentDescriptor extends MTLRenderPassAttachmentDescriptor
{
    public var clearStencil: Int;
}
