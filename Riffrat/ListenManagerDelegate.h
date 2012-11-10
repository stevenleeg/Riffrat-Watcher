//
//  ListenManagerDelegate.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/9/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"

@protocol ListenManagerDelegate <NSApplicationDelegate>

-(void) updateTrack: (Track *)track;

@end
