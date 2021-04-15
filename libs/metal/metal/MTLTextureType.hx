package metal;

@:macos(10.11)
@:ios(8.0)
@:enum abstract MTLTextureType(Int)
{
    var MTLTextureType1D = 0;
    var MTLTextureType1DArray = 1;
    var MTLTextureType2D = 2;
    var MTLTextureType2DArray = 3;
    var MTLTextureType2DMultisample = 4;
    var MTLTextureTypeCube = 5;

    @:macos(10.11)
    @:ios(11.0)
    var MTLTextureTypeCubeArray = 6;

    var MTLTextureType3D = 7;

    @:macos(10.14)
    @:ios(14.0)
    var MTLTextureType2DMultisampleArray = 8;

    @:macos(10.14)
    @:ios(12.0)
    var MTLTextureTypeTextureBuffer = 9;
}
