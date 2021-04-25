#import "CAMetalDrawable.h"
#import <QuartzCore/QuartzCore.h>
#import "MetalTexture.h"

HL_PRIM id<MTLTexture> HL_NAME(cametaldrawable_getTexture)(id<CAMetalDrawable> drawable) {
    DEBUG_NSLOG(@"cametaldrawable_getTexture: begin");
    id<MTLTexture> res = [drawable texture];
    DEBUG_NSLOG(@"cametaldrawable_getTexture: returning %@", res);
    return res;
}

DEFINE_PRIM(_MTL_TEXTURE,cametaldrawable_getTexture,_CA_METAL_DRAWABLE);
