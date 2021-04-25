package metal;

final MTLResourceCPUCacheModeShift  = 0;
final MTLResourceStorageModeShift   = 4;

@:macos(10.11)
@:ios(8.0)
@:enum abstract MTLResourceOptions(Int)
{
    var MTLResourceCPUCacheModeDefaultCache = /*MTLCPUCacheModeDefaultCache*/0 << /*MTLResourceCPUCacheModeShift*/0;

    // var MTLResourceCPUCacheModeWriteCombined = MTLCPUCacheModeWriteCombined << MTLResourceCPUCacheModeShift;

    @:macos(10.11)
    @:ios(9.0)
    var MTLResourceStorageModeShared = /*MTLStorageModeShared*/0 << /*MTLResourceStorageModeShift*/4;

    // @:macos(10.11)
    // @:macCatalyst(13.0)
    // @:ios(false)
    // var MTLResourceStorageModeManaged = MTLStorageModeManaged << MTLResourceStorageModeShift;

    // @:macos(10.11)
    // @:ios(9.0)
    // var MTLResourceStorageModePrivate = MTLStorageModePrivate << MTLResourceStorageModeShift;

    // @:macos(11.0)
    // @:macCatalyst(14.0)
    // @:ios(10.0)
    // var MTLResourceStorageModeMemoryless = MTLStorageModeMemoryless << MTLResourceStorageModeShift;

    // @:macos(10.13)
    // @:ios(10.0)
    // var MTLResourceHazardTrackingModeDefault = MTLHazardTrackingModeDefault << MTLResourceHazardTrackingModeShift;

    // @:macos(10.13)
    // @:ios(10.0)
    // var MTLResourceHazardTrackingModeUntracked = MTLHazardTrackingModeUntracked << MTLResourceHazardTrackingModeShift;

    // @:macos(10.15)
    // @:ios(13.0)
    // var MTLResourceHazardTrackingModeTracked = MTLHazardTrackingModeTracked << MTLResourceHazardTrackingModeShift;

    // // Deprecated spellings
    // var MTLResourceOptionCPUCacheModeDefault       = MTLResourceCPUCacheModeDefaultCache;
    // var MTLResourceOptionCPUCacheModeWriteCombined = MTLResourceCPUCacheModeWriteCombined;
}