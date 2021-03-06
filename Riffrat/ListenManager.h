//
//  ListenManager.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/8/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"
#import "Spotify.h"
#import "iTunes.h"
#import "Server.h"
#import "ListenManagerDelegate.h"

@interface ListenManager : NSObject {
    iTunesApplication *iTunes;
    SpotifyApplication *spotify;
    Track *currentTrack;
    NSTimer *timer;
}

@property id <ListenManagerDelegate> delegate;
@property Server *server;

-(void) updateiTunesTrackInfo: (NSNotification *) notification;
-(void) updateSpotifyTrackInfo: (NSNotification *) notification;
-(void) checkTrack;

@end
