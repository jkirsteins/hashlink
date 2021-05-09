#import "_SharedRoot.h"
#import "MetalTexture.h"
#import <CoreGraphics/CoreGraphics.h>

void _validate_region(Proxy_MTLRegion *region) {
    if (region == NULL) {
        NSLog(@"region is NULL");
        return;
    }

    if (region->origin == NULL) {
        NSLog(@"region->origin is NULL");
        return;
    }

    if (region->size == NULL) {
        NSLog(@"region->size is NULL");
        return;
    }
#if DEBUG
    NSLog(@"[MTLRegion origin(%d %d %d) size(%d %d %d)]",
          region->origin->x,
          region->origin->y,
          region->origin->z,
          region->size->width,
          region->size->height,
          region->size->depth);
#endif
}

MTLRegion _unwrap_region(Proxy_MTLRegion *region) {
    MTLRegion result;
    result.origin.x = region->origin->x;
    result.origin.y = region->origin->y;
    result.origin.z = region->origin->z;
    DEBUG_NSLOG(@"origin {%lu %lu %lu}", result.origin.x, result.origin.y, result.origin.z);
    result.size.width = region->size->width;
    result.size.height = region->size->height;
    result.size.depth = region->size->depth;
    DEBUG_NSLOG(@"size {%lu %lu %lu}", result.size.width, result.size.height, result.size.depth);
    return result;
}

HL_PRIM void HL_NAME(mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow)(id<MTLTexture> texture, Proxy_MTLRegion *region, int32_t mipmapLevel, vbyte *bytes, int32_t bytesPerRow) {
    DEBUG_NSLOG(@"mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow: start");
    _validate_region(region);
    
    DEBUG_NSLOG(@"mipmap level %d", mipmapLevel);
    DEBUG_NSLOG(@"bytes per row %d", bytesPerRow);
    
    uint8_t r = ((uint8_t*)bytes)[0];
    uint8_t g = ((uint8_t*)bytes)[1];
    uint8_t b = ((uint8_t*)bytes)[2];
    uint8_t a = ((uint8_t*)bytes)[3];
    DEBUG_NSLOG(@"first pixel %d %d %d %d", r, g, b, a);
    
    [texture replaceRegion:_unwrap_region(region) mipmapLevel:mipmapLevel withBytes:(void*)bytes bytesPerRow:bytesPerRow];
    DEBUG_NSLOG(@"mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow: end");
}

HL_PRIM void HL_NAME(mtltexture_debug_save)(id<MTLTexture> texture, vbyte *pathBytes) {
    @autoreleasepool {
        DEBUG_NSLOG(@"mtltexture_debug_save: start");
        
        // see: https://stackoverflow.com/questions/33844130/take-a-snapshot-of-current-screen-with-metal-in-swift/50618976#50618976

        NSUInteger rowBytes = texture.width * 4;
        void *p = malloc(texture.width * texture.height * 4);
        [texture getBytes:p bytesPerRow:rowBytes fromRegion:MTLRegionMake2D(0, 0, texture.width, texture.height) mipmapLevel:0];
        
        uint8_t r = ((uint8_t*)p)[0];
        uint8_t g = ((uint8_t*)p)[1];
        uint8_t b = ((uint8_t*)p)[2];
        uint8_t a = ((uint8_t*)p)[3];
        DEBUG_NSLOG(@"First pixel components: %d %d %d %d", r, g, b, a);
                     

        CGColorSpaceRef pColorSpace = CGColorSpaceCreateDeviceRGB();

        uint32_t rawBitmapInfo = kCGImageAlphaPremultipliedLast| kCGBitmapByteOrder32Little;
            
        CGDataProviderRef dataProvider = CGDataProviderCreateWithData(nil, p, texture.width * texture.height * 4, nil);
        CGImageRef img = CGImageCreate(texture.width, texture.height, 8, 32, rowBytes, pColorSpace, rawBitmapInfo, dataProvider, nil, true, kCGRenderingIntentDefault);

        
        NSString *path = [NSString stringWithUTF8String:(char*)pathBytes];
        CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
        CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
        if (!destination) {
            DEBUG_NSLOG(@"Failed to create CGImageDestination for %@", path);
            FATAL("stop");
        }

        CGImageDestinationAddImage(destination, img, nil);

        if (!CGImageDestinationFinalize(destination)) {
            DEBUG_NSLOG(@"Failed to write image to %@", path);
            CFRelease(destination);
            FATAL("stop");
        }

        CFRelease(destination);
        CFRelease(img);
        CFRelease(dataProvider);
        CFRelease(pColorSpace);
        
        free(p);
        
        DEBUG_NSLOG(@"mtltexture_debug_save: end");
    }
}

DEFINE_PRIM(_VOID,mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow,_METAL_TEXTURE _DYN _I32 _BYTES _I32);
DEFINE_PRIM(_VOID,mtltexture_debug_save,_METAL_TEXTURE _BYTES);



