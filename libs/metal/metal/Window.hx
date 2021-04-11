package metal;

import haxe.Exception;

// private typedef WinPtr = hl.Abstract<"sdl_window">;
// private typedef GLContext = hl.Abstract<"sdl_gl">;

@:enum abstract DisplayMode(Int) {
	var Windowed = 0;
	var Fullscreen = 1;
	/**
		Fullscreen not exclusive.
	**/
	var Borderless = 2;
	var FullscreenResize = 3;
}

@:hlNative("metal")
class Window {

	public var title(default, set) : String;
	public var vsync(default, set) : Bool;
	@:isVar public var width(get, set) : Int;
	@:isVar public var height(get, set) : Int;
	public var displayMode(default, set) : DisplayMode;

	public function new(title : String, width : Int, height : Int) {

		// while( true ) {
		// 	win = winCreateEx(x, y, width, height, sdlFlags);
		// 	if( win == null ) throw "Failed to create window";
		// 	glctx = winGetGLContext(win);
		// 	if( glctx == null || !GL.init() || !testGL() ) {
		// 		destroy();
		// 		if( Sdl.onGlContextRetry() ) continue;
		// 		Sdl.onGlContextError();
		// 	}
		// 	break;
		// }
		this.title = title;
		this.width = width;
		this.height = height;

		if (!@:privateAccess createMetalWindow(title.toUtf8(), width, height)) {
			throw new Exception("Failed to create a Metal window.");
		}

		// windows.push(this);
		// vsync = true;
	}

	public static function createMetalWindow(title: hl.Bytes, width: Int, height: Int): Bool {
		return false;
	}

	function set_width(w: Int) {
		return width = w;
	}

	function set_height(h: Int) {
		return height = h;
	}

	function get_width() {
		return this.width;
	}

	function get_height() {
		return this.height;
	}

	function set_displayMode(mode) {
		if( mode == displayMode )
			return mode;
		trace('Setting display mode to $mode');
		return displayMode;
	}

	function set_title(name:String) {
		trace('[metal.Window#set_title] Not implemented');
		return title = name;
	}

	function set_vsync(v:Bool) {
		trace('[metal.Window#set_vsync] Not implemented ($v)');
		return vsync = v;
	}

	public function resize( width : Int, height : Int ) {
		trace('[metal.Window#resize] Not implemented $width x $height');
	}

	public function present() {
		// trace('[metal.Window#present] Not implemented');
	}
}
