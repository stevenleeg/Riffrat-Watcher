//
//  ListenManager.m
//  Riffrat
//
//  Created by Steve Gattuso on 11/8/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import "ListenManager.h"

@implementation ListenManager

@synthesize delegate;

-(id) init {
    self = [super init];
    // Start listening to iTunes/Spotify
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(updateiTunesTrackInfo:) name:@"com.apple.iTunes.playerInfo" object:nil];
    [dnc addObserver:self selector:@selector(updateSpotifyTrackInfo:) name:@"com.spotify.client.PlaybackStateChanged" object:nil];
    
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    currentTrack = [[Track alloc] init];
    
    return self;
}

/*
 * Both of these handle notifications from iTunes and Spotify.
 */
-(void) updateSpotifyTrackInfo:(NSNotification *)notification {
    // If it's not running then don't bother
    if(![spotify isRunning])
        return;
    
    // Get the track info from iTunes
    Track *track = [[Track alloc] init];
    
    [track setArtist: [[spotify currentTrack] artist]];
    [track setAlbum: [[spotify currentTrack] album]];
    [track setName: [[spotify currentTrack] name]];
    [track setLength: [NSNumber numberWithDouble: [[spotify currentTrack] duration]]];
    
    if(![currentTrack equals: track]) {
        currentTrack = track;
        [delegate updateTrack: track];
    }
}

-(void) updateiTunesTrackInfo:(NSNotification *)notification {
    // If it's not running don't even bother.
    if(![iTunes isRunning])
        return;
    
    // Get the track info from iTunes
    Track *track = [[Track alloc] init];
    
    [track setArtist: [[iTunes currentTrack] artist]];
    [track setAlbum: [[iTunes currentTrack] album]];
    [track setName: [[iTunes currentTrack] name]];
    [track setLength: [NSNumber numberWithDouble: [[iTunes currentTrack] duration]]];
    
    if(![currentTrack equals: track]) {
        currentTrack = track;
        [delegate updateTrack: track];
    }
}

-(void) checkTrack {
    if([iTunes isRunning])
        [self updateiTunesTrackInfo:nil];
    else if([spotify isRunning])
        [self updateSpotifyTrackInfo:nil];
}

@end
