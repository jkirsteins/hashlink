package metal;

@:hlNative("metal", "nsapp_")
// @:hlNative("sdl")
class NSApplication {
    public static function init(): Bool {
        return false;
	}

    public static function eventLoop( e : Dynamic ) {
        return false;
    }

    static var event = new Event();
    public static function processEvents( onEvent : Event -> Bool ) {
		while( true ) {
			if( !eventLoop(event) )
				break;
			trace('Got true from eventLoop');
			var ret = onEvent(event);
			if( event.type == Quit && ret ) {
                trace("Got Quit event");
				return false;
            }
		}
		return true;
	}
}
