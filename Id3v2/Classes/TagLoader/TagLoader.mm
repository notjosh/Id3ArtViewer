//
//  TagLoader.mm
//  Id3v2
//
//  Created by compo on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TagLoader.h"

#include "tag_c.h"

#include <mpegfile.h>

#include <id3v2tag.h>
#include <id3v2frame.h>
#include <id3v2header.h>

#include <id3v1tag.h>

#include <iostream>
#include <stdlib.h>

using namespace std;
using namespace TagLib;


@interface TagLoader (Temporary)
- (void)cReadTags:(NSString *)path;
- (void)cppReadTags:(NSString *)path;
@end

@implementation TagLoader

- (void)dealloc {
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)loadFileAtPath:(NSString *)path {
    NSLog(@"loading file at path: '%@'", path);

    [self cppReadTags:path];
}

- (void)cppReadTags:(NSString *)path {
    MPEG::File f([path cStringUsingEncoding:NSUTF8StringEncoding]);

    ID3v2::Tag *id3v2tag = f.ID3v2Tag();

    if(id3v2tag) {
        
        cout << "ID3v2."
        << id3v2tag->header()->majorVersion()
        << "."
        << id3v2tag->header()->revisionNumber()
        << ", "
        << id3v2tag->header()->tagSize()
        << " bytes in tag"
        << endl;
        
        ID3v2::FrameList::ConstIterator it = id3v2tag->frameList().begin();
        for(; it != id3v2tag->frameList().end(); it++)
            cout << (*it)->frameID() << " - \"" << (*it)->toString() << "\"" << endl;
    }
    else
        cout << "file does not have a valid id3v2 tag" << endl;

    cout << endl << "ID3v1" << endl;
    
    ID3v1::Tag *id3v1tag = f.ID3v1Tag();
    
    if(id3v1tag) {
        cout << "title   - \"" << id3v1tag->title()   << "\"" << endl;
        cout << "artist  - \"" << id3v1tag->artist()  << "\"" << endl;
        cout << "album   - \"" << id3v1tag->album()   << "\"" << endl;
        cout << "year    - \"" << id3v1tag->year()    << "\"" << endl;
        cout << "comment - \"" << id3v1tag->comment() << "\"" << endl;
        cout << "track   - \"" << id3v1tag->track()   << "\"" << endl;
        cout << "genre   - \"" << id3v1tag->genre()   << "\"" << endl;
    }
    else
        cout << "file does not have a valid id3v1 tag" << endl;
}

- (void)cReadTags:(NSString *)path {
    // Initialisation as per the TagLib example C code
    TagLib_File *file;
    TagLib_Tag *tag;
    
    // We want UTF8 strings out of TagLib
    taglib_set_strings_unicode(TRUE);
    
    file = taglib_file_new([path cStringUsingEncoding:NSUTF8StringEncoding]);
    
    if (file != NULL) {
        tag = taglib_file_tag(file);
        
        if (tag != NULL) {

            if (taglib_tag_title(tag) != NULL &&
                strlen(taglib_tag_title(tag)) > 0) {
                NSString *title = [NSString stringWithCString:taglib_tag_title(tag)
                                                encoding:NSUTF8StringEncoding];
                NSLog(@"title: %@", title);
            }
            
            if (taglib_tag_artist(tag) != NULL &&
                strlen(taglib_tag_artist(tag)) > 0) {
                NSString *artist = [NSString stringWithCString:taglib_tag_artist(tag)
                                                      encoding:NSUTF8StringEncoding];
                NSLog(@"artist: %@", artist);
            }
            
            if (taglib_tag_album(tag) != NULL &&
                strlen(taglib_tag_album(tag)) > 0) {
                NSString *album = [NSString stringWithCString:taglib_tag_album(tag)
                                                     encoding:NSUTF8StringEncoding];
                NSLog(@"album: %@", album);
            }
            
            if (taglib_tag_comment(tag) != NULL &&
                strlen(taglib_tag_comment(tag)) > 0) {
                NSString *comment = [NSString stringWithCString:taglib_tag_comment(tag)
                                                       encoding:NSUTF8StringEncoding];
                NSLog(@"comment: %@", comment);
            }
            
            if (taglib_tag_genre(tag) != NULL &&
                strlen(taglib_tag_genre(tag)) > 0) {
                NSString *genre = [NSString stringWithCString:taglib_tag_genre(tag)
                                                     encoding:NSUTF8StringEncoding];
                NSLog(@"genre: %@", genre);
            }
            
            // Year and track are uints
            if (taglib_tag_year(tag) > 0) {
                NSNumber *year = [NSNumber numberWithUnsignedInt:taglib_tag_year(tag)];
                NSLog(@"year: %@", year);
            }
            
            if (taglib_tag_track(tag) > 0) {
                NSNumber *track = [NSNumber numberWithUnsignedInt:taglib_tag_track(tag)];
                NSLog(@"track: %@", track);
            }
        } else {
            NSLog(@"No valid tags");
        }
        
        const TagLib_AudioProperties *properties = taglib_file_audioproperties(file);
        
        if (properties != NULL) {

            
            if (taglib_audioproperties_length(properties) > 0) {
                NSNumber *length = [NSNumber numberWithInt:taglib_audioproperties_length(properties)];
                NSLog(@"length: %@", length);
            }
        } else {
            NSLog(@"No valid audio properties");
        }
        
        // Free up our used memory so far
        taglib_tag_free_strings();
        taglib_file_free(file);
        
    }
}

@end
