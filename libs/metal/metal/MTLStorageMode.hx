package metal;

@:macos(10.11)
@:ios(9.0)
@:enum abstract MTLStorageMode(Int)
{
    var MTLStorageModeShared  = 0;

    @:macos(10.11)
    @:macCatalyst(13.0)
    @:ios(false)
    var MTLStorageModeManaged = 1;

    var MTLStorageModePrivate = 2;

    @:macos(11.0)
    @:macCatalyst(14.0)
    @:ios(10.0)
    var MTLStorageModeMemoryless = 3;
}
