package metal;

@:macos(10.11)
@:ios(8.0)
@:enum abstract MTLLoadAction(Int) {
	var MTLLoadActionDontCare = 0;
    var MTLLoadActionLoad = 1;
    var MTLLoadActionClear = 2;
}
