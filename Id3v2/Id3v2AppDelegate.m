//
//  Id3v2AppDelegate.m
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Id3v2AppDelegate.h"

@implementation Id3v2AppDelegate

@synthesize mainWindowController = _mainWindowController;

- (void)dealloc {
    [_mainWindowController release], _mainWindowController = nil;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_mainWindowController showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
