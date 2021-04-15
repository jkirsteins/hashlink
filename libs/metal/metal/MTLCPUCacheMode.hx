package metal;

@:macos(10.11)
@:ios(8.0)
@:enum abstract MTLCPUCacheMode(Int)
{
    var MTLCPUCacheModeDefaultCache = 0;
    var MTLCPUCacheModeWriteCombined = 1;
}
