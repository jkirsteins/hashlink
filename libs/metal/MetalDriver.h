#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#import "MetalWindow.h"

typedef enum {
    Depth32Float_Stencil8    = 260
} mtl_pixel_format;

@interface MetalDriver : NSObject
{
}

- (id)initWithWindow:(MetalWindow*)window;
-(id<MTLDevice>)device;
-(MTKView*)metalView;
-(void)present;
-(void)setSize:(CGSize)newSize;

@end
