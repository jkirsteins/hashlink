package metal;

@:macos(10.11)
@:ios(8.0)
@:enum abstract MTLPrimitiveType(Int) {
    var MTLPrimitiveTypePoint = 0;
    var MTLPrimitiveTypeLine = 1;
    var MTLPrimitiveTypeLineStrip = 2;
    var MTLPrimitiveTypeTriangle = 3;
    var MTLPrimitiveTypeTriangleStrip = 4;
}
