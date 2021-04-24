/**
    The MTLRenderPassAttachmentDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:structInit
@:keep
class MTLRenderPassAttachmentDescriptor
{
    public var loadAction: MTLLoadAction;
    public var storeAction: MTLStoreAction;
}
