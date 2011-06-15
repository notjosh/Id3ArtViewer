//
//  Id3v2AppDelegate.h
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;

@interface Id3v2AppDelegate : NSObject <NSApplicationDelegate> {
@private
    MainWindowController *_mainWindowController;
}

@property (assign) IBOutlet MainWindowController *mainWindowController;

@end
