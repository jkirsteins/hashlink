#define HL_NAME(n) metal_##n

#include <hl.h>
#import "MetalView.h"

@implementation MetalView {
}

- (id)initWithFrame:(CGRect)inFrame {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    self = [super initWithFrame:inFrame device:device];

    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {

}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}
@end
