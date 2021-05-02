package metal;

typedef DriverInstance = hl.Abstract<"metal_driver">;

@:enum abstract DriverInitFlags(Int) {
	var None = 0;
	@:op(a | b) static function or(a:DriverInitFlags, b:DriverInitFlags) : DriverInitFlags;
}

@:hlNative("metal", "driver_")
class Driver {

    var driver: DriverInstance;
    public var device(default, null): metal.MTLDevice;

    public function new( win : Window ) {
        driver = nativeCreate( @:privateAccess win.win );
        device = new MTLDevice( nativeGetDevice(driver) );
    }

    @:deprecated public function createIndexBuffer(size: Int): MTLBuffer
    {
        return createBuffer(size);
    }

    @:deprecated public function createVertexBuffer(size: Int): MTLBuffer
    {
        return createBuffer(size);
    }

    @:deprecated public function createBuffer(size: Int): MTLBuffer
    {
        return device.newBufferWithLengthOptions(size, MTLResourceOptions.MTLResourceStorageModeShared);
    }

    public function resizeViewport(width: Int, height: Int) {
        nativeResizeViewport(driver, width, height);
    }

    public function setDepthStencilFormat( format: MTLPixelFormat ) {
        nativeSetDepthStencilFormat( driver, format );
    }

    public function createTexture( descriptor: MTLTextureDescriptor ): MTLTexture {
        return new MTLTexture(nativeCreateTexture( driver, descriptor ));
    }

    public function getCurrentDrawable(): CAMetalDrawable {
        var drawablePtr = Driver.nativeGetCurrentDrawable( driver );
        if (drawablePtr == null) {
            return null;
        }
        return new CAMetalDrawable( drawablePtr );
    }

    @:hlNative("metal","driver_get_current_drawable")
    static function nativeGetCurrentDrawable( driver: DriverInstance ): CAMetalDrawablePtr {
        return null;
    }

    @:hlNative("metal","driver_create_texture")
    static function nativeCreateTexture( driver: DriverInstance, descriptor: Dynamic ): MTLTexturePtr {
        return null;
    }

    @:hlNative("metal","driver_get_device")
    static function nativeGetDevice( driver: DriverInstance ): MTLDevicePtr {
        return null;
    }

    @:hlNative("metal","driver_resize_viewport")
    static function nativeResizeViewport( driver: DriverInstance, w: Int, h: Int ) {

    }

    @:hlNative("metal","driver_set_depth_stencil_format")
    static function nativeSetDepthStencilFormat( driver: DriverInstance, format: MTLPixelFormat ) {

    }

    @:hlNative("metal","driver_create")
	static function nativeCreate( win : hl.Abstract<"metal_window"> ) : DriverInstance {
        return null;
    }
}