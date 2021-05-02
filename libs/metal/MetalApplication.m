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

#import "MetalApplication.h"
#import "MetalWindow.h"
#import "MetalView.h"

#include <Appkit/AppKit.h>

@interface AppDelegate : NSObject<NSApplicationDelegate>
{
}

@end

@implementation AppDelegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return TRUE;
}

-(void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
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

}

@end


MetalApplication *applicationObject = nil;
static BOOL finishedLaunching = false;


HL_PRIM bool HL_NAME(nsapp_init)() {
	@autoreleasepool {
		if (applicationObject != nil) {
			return false;
		}

		applicationObject = [MetalApplication sharedApplication];

		applicationObject.delegate = [[AppDelegate alloc] init];

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

DEFINE_PRIM(_BOOL,nsapp_event_loop,_DYN );
DEFINE_PRIM(_BOOL,nsapp_init,_NO_ARG);

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

            if (NSApp.windows.count == 0) {
                event->type = Quit;
                NSLog(@"Returning Quit because no more windows");
                return true;
            }

			NSEvent *nsEvent =
				[self
					nextEventMatchingMask:NSEventMaskAny
					untilDate:[NSDate distantPast]
					inMode:NSDefaultRunLoopMode
					dequeue:YES];
            if (nsEvent == nil) {
                break;
            }
            
            [self sendEvent:nsEvent];
            [self updateWindows];
            
            switch (nsEvent.type) {
                case NSEventTypeMouseMoved:
                    event->type = MouseMove;
                    return true;
                case NSEventTypeLeftMouseDown:
                    event->type = MouseDown;
                case NSEventTypeRightMouseDown:
                    event->type = MouseDown;
                case NSEventTypeLeftMouseUp:
                    event->type = MouseUp;
                case NSEventTypeRightMouseUp:
                    event->type = MouseUp;
                    return true;
                case NSEventTypeMouseExited:
                    event->type = MouseLeave;
                    return true;
                case NSEventTypeScrollWheel:
                    event->type = MouseWheel;
                    return true;
                case NSEventTypeKeyDown:
                    event->type = KeyDown;
                    return true;
                case NSEventTypeKeyUp:
                    event->type = KeyUp;
                    return true;
                case NSEventTypeLeftMouseDragged:
                case NSEventTypeRightMouseDragged:
                case NSEventTypeOtherMouseDragged:
                    event->type = MouseMove;
                    return true;
                case NSEventTypePressure:
                    continue;
                case NSEventTypeMouseEntered:
                    continue;
                case NSEventTypeAppKitDefined:
                    continue;
                case NSEventTypeSystemDefined:
                    continue;
                case NSEventTypeFlagsChanged:
                    continue;
                default:
                    NSLog(@"Unknown event %@...", nsEvent);
                    NSLog(@"Debug desc %@...", nsEvent.debugDescription);
                    hl_fatal_error("unknown event", __FILE__, __LINE__);
            }
            
            event->type = 1337; // tmp to not force a quit

			long subtype = -1;
			if(
				[nsEvent type] == NSEventTypeAppKitDefined ||
				[nsEvent type] == NSEventTypeSystemDefined ||
				[nsEvent type] == NSEventTypeApplicationDefined ||
				[nsEvent type] == NSEventTypePeriodic ) {

				subtype = [nsEvent subtype];
			}

			// NSLog(@"NSEvent with type: %ld and subtype: %ld", event.type, subtype);

			return true;
		}

		return false;
	}
}

@end

