#define HL_NAME(n) metal_##n

#include <hl.h>
#import <Cocoa/Cocoa.h>

#define _WINPTR _ABSTRACT(metal_window)

@interface MetalWindow : NSWindow
{
}

-(void)testForHaxe;

@end
