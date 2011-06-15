//
//  MainWindowController.h
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MainWindowController : NSWindowController <NSWindowDelegate> {
@private
    NSTextField *_path;
    NSTextView  *_description;
    NSImageView *_albumArtView;
}

@property (assign) IBOutlet NSTextField *path;
@property (assign) IBOutlet NSTextView  *description;
@property (assign) IBOutlet NSImageView *albumArtView;

@end
