#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#import "MetalWindow.h"

@interface MetalDriver : NSObject
{
}

- (id)initWithWindow:(MetalWindow*)window;
-(id<MTLDevice>)device;
-(MTKView*)metalView;
-(void)present;
-(void)setSize:(CGSize)newSize;

@end
