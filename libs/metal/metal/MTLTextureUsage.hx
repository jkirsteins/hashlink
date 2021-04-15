package metal;

@:macos(10.11)
@:ios(9.0)
@:enum abstract MTLTextureUsage(Int)
{
    var MTLTextureUsageUnknown         = 0x0000;
    var MTLTextureUsageShaderRead      = 0x0001;
    var MTLTextureUsageShaderWrite     = 0x0002;
    var MTLTextureUsageRenderTarget    = 0x0004;
    var MTLTextureUsagePixelFormatView = 0x0010;
}
