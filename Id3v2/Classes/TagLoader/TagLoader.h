//
//  TagLoader.h
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TagLoader : NSObject {
@private
    NSString *_title;
    NSString *_artist;
    NSString *_album;
    NSNumber *_year;
    NSString *_comment;
    NSNumber *_track;
    NSString *_genre;
    NSImage  *_albumArt;
}

- (void)loadFileAtPath:(NSString *)path;

@property (readonly) NSString *title;
@property (readonly) NSString *artist;
@property (readonly) NSString *album;
@property (readonly) NSNumber *year;
@property (readonly) NSString *comment;
@property (readonly) NSNumber *track;
@property (readonly) NSString *genre;
@property (readonly) NSImage  *albumArt;

@end
