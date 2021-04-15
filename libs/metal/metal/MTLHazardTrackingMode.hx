package metal;

@:macos(10.15)
@:ios(13.0)
@:enum abstract MTLHazardTrackingMode(Int)
{
    var MTLHazardTrackingModeDefault = 0;
    var MTLHazardTrackingModeUntracked = 1;
    var MTLHazardTrackingModeTracked = 2;
}
