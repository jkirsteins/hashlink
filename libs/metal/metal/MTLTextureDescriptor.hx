/**
    The MTLTextureDescriptor is an NSObject. This is a
    proxy structure for passing data to/from the Obj-C
    environment.
**/
package metal;

@:keep
class MTLTextureDescriptor
{
    public function new() {

    }

    public var width : Int;
    public var height : Int;
    public var depth : Int;

    public var textureType: MTLTextureType;
    public var pixelFormat: MTLPixelFormat;

    public var mipmapLevelCount: Int;
    public var sampleCount: Int;
    public var arrayLength: Int;
    public var resourceOptions: MTLResourceOptions;
    public var cpuCacheMode: MTLCPUCacheMode;
    public var storageMode: MTLStorageMode;
    public var hazardTrackingMode: MTLHazardTrackingMode;
    public var allowGPUOptimizedContents: Bool;
    public var usage: MTLTextureUsage;
    public var swizzle: MTLTextureSwizzleChannels;
}
