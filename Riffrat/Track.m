//
//  Track.m
//  Riffrat
//
//  Created by Steve Gattuso on 11/9/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import "Track.h"

@implementation Track

@synthesize name;
@synthesize album;
@synthesize artist;

-(id) init {
    if(self = [super init]) {
        // By default the song hasn't been sent
        [self setSent: [NSNumber numberWithInt: 0]];
    }
    return self;
}

-(bool) equals: (Track *) track {
    // Check the song name
    if(![[self name] isEqualToString: [track name]])
        return false;
    
    // Album name
    if(![[self album] isEqualToString: [track album]])
        return false;
    
    // And artist name
    if(![[self artist] isEqualToString: [track artist]])
        return false;
    
    // If those three are equal then we're good.
    return true;
}

@end
