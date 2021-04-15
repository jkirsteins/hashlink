package metal;

@:macos(10.15)
@:ios(13.0)
@:enum abstract MTLTextureSwizzle(Int) {
    var MTLTextureSwizzleZero = 0;
    var MTLTextureSwizzleOne = 1;
    var MTLTextureSwizzleRed = 2;
    var MTLTextureSwizzleGreen = 3;
    var MTLTextureSwizzleBlue = 4;
    var MTLTextureSwizzleAlpha = 5;
}
