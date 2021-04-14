package metal;

typedef DriverInstance = hl.Abstract<"metal_driver">;

@:enum abstract DriverInitFlags(Int) {
	var None = 0;
	@:op(a | b) static function or(a:DriverInitFlags, b:DriverInitFlags) : DriverInitFlags;
}

@:hlNative("metal", "driver_")
class Driver {

    var driver: DriverInstance;

    public function new( win : Window ) {
        driver = nativeCreate( @:privateAccess win.win );
    }

    public function createIndexBuffer(size: Int): Buffer
    {
        return createBuffer(size);
    }

    public function createVertexBuffer(size: Int): Buffer
    {
        return createBuffer(size);
    }

    public function createBuffer(size: Int): Buffer
    {
        return @:privateAccess new Buffer(Driver.nativeCreateBuffer( driver, size ));
    }

    public function updateBuffer(
        buffer : metal.Buffer,
        data: hl.Bytes,
        offset: Int,
        size: Int) {
        nativeUpdateBuffer(
            @:privateAccess buffer.buffer,
            data,
            offset,
            size);
    }

    public function resizeViewport(width: Int, height: Int) {
        nativeResizeViewport(driver, width, height);
    }

    public function setDepthStencilFormat( format: PixelFormat ) {
        nativeSetDepthStencilFormat( driver, format );
    }

    @:hlNative("metal","driver_resize_viewport")
    static function nativeResizeViewport( driver: DriverInstance, w: Int, h: Int ) {

    }

    @:hlNative("metal","driver_set_depth_stencil_format")
    static function nativeSetDepthStencilFormat( driver: DriverInstance, format: PixelFormat ) {

    }

    @:hlNative("metal","driver_create")
	static function nativeCreate( win : hl.Abstract<"metal_window"> ) : DriverInstance {
        return null;
    }

    @:hlNative("metal","driver_create_buffer")
	static function nativeCreateBuffer( driver : DriverInstance, size: Int ) : metal.MetalBufferInstance {
        return null;
    }

    @:hlNative("metal","driver_update_buffer")
	static function nativeUpdateBuffer(
        buffer : metal.MetalBufferInstance,
        data: hl.Bytes,
        offset: Int,
        size: Int) {

    }
}