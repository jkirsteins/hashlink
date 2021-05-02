package metal;

import haxe.Int64;

@:allow(metal.Driver)
@:hlNative("metal", "mtldevice_")
class MTLDevice extends MetalResource<MTLDevicePtr> {
    public function newLibraryFromSource(source: String): MTLLibrary
    {
        return new MTLLibrary( MTLDevice.nativeNewLibraryFromSource( ptr, @:privateAccess source.toUtf8() ) );
    }

    public function newRenderPipelineStateWithDescriptor(desc: MTLRenderPipelineDescriptor): MTLRenderPipelineState
    {
        return new MTLRenderPipelineState( MTLDevice.nativeNewRenderPipelineStateWithDescriptor( ptr, desc ) );
    }

    public function newCommandQueue(): MTLCommandQueue {
        return new MTLCommandQueue(MTLDevice.nativeNewCommandQueue( ptr ));
    }

    public function newBufferWithLengthOptions( size: Int, options: MTLResourceOptions ): metal.MTLBuffer {
        if (size == 0) {
            throw 'Can not create a buffer with size 0';
        }

        var ptr = MTLDevice.nativeNewBufferWithLengthOptions( ptr, size, cast(options, Int) );
        if (ptr == null) {
            throw 'Failed to create a buffer (got NULL)';
        }
        return new MTLBuffer( ptr );
    }

    @:hlNative("metal", "mtldevice_newCommandQueue")
    private static function nativeNewCommandQueue(device: MTLDevicePtr): MTLCommandQueuePtr {
        return null;
    }

    @:hlNative("metal", "mtldevice_newLibrary_source")
    private static function nativeNewLibraryFromSource(device: MTLDevicePtr, source: hl.Bytes): MTLLibraryPtr {
        return null;
    }

    @:hlNative("metal", "mtldevice_newRenderPipelineState_descriptor")
    private static function nativeNewRenderPipelineStateWithDescriptor(device: MTLDevicePtr, desc: Dynamic ): MTLRenderPipelineStatePtr {
        return null;
    }

    @:hlNative("metal","mtldevice_newBuffer_length_options")
	private static function nativeNewBufferWithLengthOptions( device : MTLDevicePtr, size: Int, options: Int ) : metal.MTLBufferPtr {
        return null;
    }
}
