package metal;

@:enum abstract MTLPixelFormat(Int) {
	@:macos(10.11)
	@:ios(9.0)
	var MTLPixelFormatDepth32Float_Stencil8	= 260;

	var MTLPixelFormatR8Unorm 				= 10;

	var MTLPixelFormatRG8Unorm				= 30;
	var MTLPixelFormatR16Float				= 25;

	var MTLPixelFormatR32Float 				= 55;
	var MTLPixelFormatRG16Float  			= 65;

	var MTLPixelFormatRGBA8Unorm 			= 70;
	var MTLPixelFormatRGBA8Unorm_sRGB 		= 71;

	var MTLPixelFormatRGB10A2Unorm 			= 90;
	var MTLPixelFormatRG11B10Float 			= 92;

	var MTLPixelFormatRG32Float 			= 105;
	var MTLPixelFormatRGBA16Float  			= 115;

	var MTLPixelFormatRGBA32Float 			= 125;

	@:macos(10.11)
	@:macCatalyst(13.0)
	@:ios(14.0)
	var MTLPixelFormatBC1_RGBA				= 130;

}
