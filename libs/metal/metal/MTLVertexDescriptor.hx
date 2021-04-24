/**
    The MTLVertexDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:keep
class MTLVertexDescriptor
{
    public var attributes(default, null): Array<MTLVertexAttributeDescriptor> = [];
    public var layouts(default, null): Array<MTLVertexBufferLayoutDescriptor> = [];
}
