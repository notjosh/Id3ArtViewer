//
//  MainWindowController.m
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainWindowController.h"

#import "TagLoader.h"

@interface MainWindowController (Private)
- (void)loadMp3Info:(NSString *)path;
@end

@implementation MainWindowController

@synthesize path = _path;
@synthesize description = _description;
@synthesize albumArtView = _albumArtView;

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

- (void)awakeFromNib {
    [_albumArtView unregisterDraggedTypes];
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
    TagLoader *tl = [[TagLoader alloc] init];
    [tl loadFileAtPath:path];

    [_path setStringValue:[path lastPathComponent]];

    NSMutableString *s = [NSMutableString string];
    [s appendFormat:@"Title:   %@\n", tl.title];
    [s appendFormat:@"Artist:  %@\n", tl.artist];
    [s appendFormat:@"Album:   %@\n", tl.album];
    [s appendFormat:@"Year:    %@\n", tl.year];
    [s appendFormat:@"Comment: %@\n", tl.comment];
    [s appendFormat:@"Track:   %@\n", tl.track];
    [s appendFormat:@"Genre:   %@",   tl.title];
    [_description setString:s];
    [[_description textStorage] setFont:[NSFont userFixedPitchFontOfSize:0.0f]];
    
    [_albumArtView setImage:tl.albumArt];

    [tl release];
}

@end
