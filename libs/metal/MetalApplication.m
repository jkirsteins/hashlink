//
// MetalApplication.m
// Based on MyApplication.m (RecreatingNSApplication) by
//
//  Original created by Matt Gallagher on 17/01/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#define HL_NAME(n) metal_##n

#include <hl.h>
#import "MetalApplication.h"

#include <Appkit/AppKit.h>

@interface MetalWindow : NSWindow
{
}

@end

@implementation MetalWindow

- (BOOL)canBecomeMainWindow {
    NSLog(@"Can become main?");
    return YES;
}

- (BOOL)canBecomeKeyWindow {
    NSLog(@"Can become key?");
    return YES;
}

- (void)close {
    NSLog(@"Closed");
    [super close];
}

@end

@interface AppDelegate : NSObject<NSApplicationDelegate>
{
}

@end

@implementation AppDelegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	NSLog(@"Last window closed");
	return TRUE;
}

-(void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
	NSLog(@"Will finish launching");

	// menu
	id menubar = [NSMenu new];
	id appMenuItem = [NSMenuItem new];
	[menubar addItem:appMenuItem];
	[NSApp setMainMenu:menubar];

	// Then we add the quit item to the menu. Fortunately the action is simple since terminate: is
	// already implemented in NSApplication and the NSApplication is always in the responder chain.
	id appMenu = [NSMenu new];
	id appName = [[NSProcessInfo processInfo] processName];
	id quitTitle = [@"Quit " stringByAppendingString:appName];
	id quitMenuItem = [[NSMenuItem alloc] initWithTitle:quitTitle
												action:@selector(terminate:) keyEquivalent:@"q"];
	[appMenu addItem:quitMenuItem];
	[appMenuItem setSubmenu:appMenu];

  	[[NSApplication sharedApplication] setPresentationOptions:NSApplicationPresentationDefault];
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[NSApp activateIgnoringOtherApps:YES];
	NSLog(@"Did finish launching");
}


-(void)applicationDidBecomeActive:(NSNotification *)notification
{
	NSLog(@"Did become active (delegate)");
}

@end


static MetalApplication *applicationObject = nil;
static BOOL finishedLaunching = false;


HL_PRIM bool HL_NAME(nsapp_init)() {
	@autoreleasepool {
		if (applicationObject != nil) {
			return false;
		}

		// NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

		applicationObject = [MetalApplication sharedApplication];

		if (NSApplication.sharedApplication.class == MetalApplication.class) {
			NSLog(@"Is good member");
		} else {
			NSLog(@"Is bad member");
		}

		applicationObject.delegate = [[AppDelegate alloc] init];


		// [pool release];

		NSLog(@"Initialized");
		return true;
	}
}

HL_PRIM bool HL_NAME(nsapp_event_loop)(event_data *event) {
	@autoreleasepool {
		if (applicationObject == nil) {
			NSLog(@"Can not enter event loop. Application is not initialized.");
			return false;
		}

		return [applicationObject eventLoop:event];
	}
}

HL_PRIM bool HL_NAME(create_metal_window)(vbyte *title, int width, int height) {
	@autoreleasepool {
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
		MTKView* view = [[MTKView alloc] initWithFrame:frame];
		window.contentView = view;
        [window setInitialFirstResponder:view];

		NSLog(@"Making window key and front");
		[window makeKeyAndOrderFront:nil];




		return true;
	}
}

DEFINE_PRIM(_BOOL,nsapp_event_loop,_DYN );
DEFINE_PRIM(_BOOL,nsapp_init,_NO_ARG);
DEFINE_PRIM(_BOOL,create_metal_window,_BYTES _I32 _I32);

@implementation MetalApplication

- (void)terminate:(id)sender
{
    NSLog(@"Got TERMINATE");
}

- (BOOL)eventLoop:(event_data*)event;
{
	@autoreleasepool {
		if (!finishedLaunching) {
			finishedLaunching = TRUE;
			[applicationObject finishLaunching];
			NSLog(@"Finished launching from loop");
		}
	//	[self finishLaunching];

		/*
		[[NSNotificationCenter defaultCenter]
			postNotificationName:NSApplicationWillFinishLaunchingNotification
			object:NSApp];
		[[NSNotificationCenter defaultCenter]
			postNotificationName:NSApplicationDidFinishLaunchingNotification
			object:NSApp];
			*/

		while (true) {
			// NSLog(@"Waiting for the next event...");
			// NSLog(@"(window count: %lu)", NSApp.windows.count);
            
            if (NSApp.windows.count == 0) {
                event->type = Quit;
                NSLog(@"Returning Quit");
                return true;
            }
            
			NSEvent *event =
				[self
					nextEventMatchingMask:NSEventMaskAny
					untilDate:[NSDate distantFuture]
					inMode:NSDefaultRunLoopMode
					dequeue:YES];

			long subtype = -1;
			if(
				[event type] == NSEventTypeAppKitDefined ||
				[event type] == NSEventTypeSystemDefined ||
				[event type] == NSEventTypeApplicationDefined ||
				[event type] == NSEventTypePeriodic ) {

				subtype = [event subtype];
			}

			// NSLog(@"NSEvent with type: %ld and subtype: %ld", event.type, subtype);

			[self sendEvent:event];
			[self updateWindows];
		}

		return false;
	}
}

@end

