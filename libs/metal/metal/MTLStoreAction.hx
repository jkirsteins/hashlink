package metal;

@:macos(10.11)
@:ios(8.0)
@:enum abstract MTLStoreAction(Int) {
	var MTLStoreActionDontCare = 0;
    var MTLStoreActionStore = 1;
    var MTLStoreActionMultisampleResolve = 2;

    @:macos(10.12)
    @:ios(10.0)
    var MTLStoreActionStoreAndMultisampleResolve = 3;

    @:macos(10.12)
    @:ios(10.0)
    var MTLStoreActionUnknown = 4;

    @:macos(10.13)
    @:ios(11.0)
    var MTLStoreActionCustomSampleDepthStore = 5;
}
