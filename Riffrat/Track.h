//
//  Track.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/9/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (retain) NSString *artist;
@property (retain) NSString *album;
@property (retain) NSString *name;
@property (retain) NSNumber *length;
@property (retain) NSNumber *sent;

-(bool) equals: (Track *) track;

@end
