#define HL_NAME(n) metal_##n

#include <hl.h>
#import "MetalWindow.h"
#import "MetalView.h"
#import "MetalApplication.h"


@implementation MetalWindow

- (BOOL)canBecomeMainWindow {
    return YES;
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (void)close {
    [super close];
}

- (void)testForHaxe {
    NSLog(@">> Testing this window for Haxe <<");
}

@end

HL_PRIM MetalWindow* HL_NAME(window_create)(vbyte *title, int width, int height) {
    if (applicationObject == nil) {
        NSLog(@"Can not create a window. Application is not initialized.");
        return false;
    }

    NSLog(@"Creating window %d x %d (%s)", width, height, (char*)title);

    // Window.
    NSRect frame = NSMakeRect(0, 0, width, height);
    MetalWindow* window = [[MetalWindow alloc]
                            initWithContentRect:frame styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable
                            backing:NSBackingStoreBuffered defer:NO];
    [window cascadeTopLeftFromPoint:NSMakePoint(20,20)];
    window.title = [NSString stringWithUTF8String:(char*)title];
    [window makeKeyAndOrderFront:nil];

//        [window setLevel:NSMainMenuWindowLevel + 1];

    [window center];


    // Custom MTKView.
    MetalView* view = [[MetalView alloc] initWithFrame:frame];
    window.contentView = view;
    [window setInitialFirstResponder:view];

    NSLog(@"Making window key and front");
    [window makeKeyAndOrderFront:nil];

    return window;
}

HL_PRIM void HL_NAME(window_test)(MetalWindow* win) {
    @autoreleasepool {
        NSLog(@"Window pointer test");
        [win testForHaxe];
    }
}

HL_PRIM void HL_NAME(window_draw)(MetalWindow* win) {
    @autoreleasepool {
        NSLog(@"window_draw: begin");
        [((MetalView*)[win contentView]) draw];
        NSLog(@"window_draw: end");
    }
}

DEFINE_PRIM(_WINPTR,window_create,_BYTES _I32 _I32);
DEFINE_PRIM(_VOID,window_test,_WINPTR);
DEFINE_PRIM(_VOID,window_draw,_WINPTR);
