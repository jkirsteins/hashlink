#import "_SharedRoot.h"
#import "MetalTexture.h"

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
    result.size.width = region->size->width;
    result.size.height = region->size->height;
    result.size.depth = region->size->depth;
    return result;
}

HL_PRIM void HL_NAME(mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow)(id<MTLTexture> texture, Proxy_MTLRegion *region, int32_t mipmapLevel, vbyte *bytes, int32_t bytesPerRow) {
    NSLog(@"mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow");
    _validate_region(region);
    
    [texture replaceRegion:_unwrap_region(region) mipmapLevel:mipmapLevel withBytes:(void*)bytes bytesPerRow:bytesPerRow];
}

DEFINE_PRIM(_VOID,mtltexture_replace_region_mipmapLevel_bytes_bytesPerRow,_METAL_TEXTURE _DYN _I32 _BYTES _I32);



