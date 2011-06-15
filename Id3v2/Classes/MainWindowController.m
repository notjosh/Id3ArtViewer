//
//  MainWindowController.m
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController (Private)
- (void)loadMp3Info:(NSString *)path;
@end

@implementation MainWindowController

- (void)dealloc {
    [super dealloc];
}

- (id)init {
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
    }
    
    return self;
}

- (void)windowDidLoad {
    NSLog(@"windowDidLoad");

    [super windowDidLoad];

    [[self window] registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)info {
    NSArray *draggedPaths = [[info draggingPasteboard] propertyListForType:NSFilenamesPboardType];

    for (NSString *path in draggedPaths) {
        if (NSOrderedSame == [@"mp3" caseInsensitiveCompare:[path pathExtension]]) {
            return NSDragOperationCopy;
        }
    }

    return NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)info {

    NSArray *draggedPaths = [[info draggingPasteboard] propertyListForType:NSFilenamesPboardType];

    for (NSString *path in draggedPaths) {
        if (NSOrderedSame != [@"mp3" caseInsensitiveCompare:[path pathExtension]]) {
            continue;
        }

        [self loadMp3Info:path];

        // break so we can only possibly load one file
        break;
    }

    return YES;
}

@end

@implementation MainWindowController (Private)

- (void)loadMp3Info:(NSString *)path {
    NSLog(@"loading file info for: %@", path);
}

@end
