//
//  AppDelegate.m
//  Riffrat
//
//  Created by Steve Gattuso on 11/8/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import "MenuDelegate.h"

@implementation MenuDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Create the status bar item
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    [self.statusItem setMenu: _menu];
    [self.statusItem setTitle: @"R"];
    [self.statusItem setHighlightMode: YES];
    
    // Create a server object
    [self setServer: [[Server alloc] init]];
    [[self server] setListenDelegate: self];
    // And listen manager
    listenManager = [[ListenManager alloc] init];
    [listenManager setDelegate: self];
    [listenManager checkTrack];
    
    [preferencesDelegate setServer: [self server]];
    [preferencesDelegate applicationDidFinishLoading: aNotification];
}

-(void) updateTrack:(Track *)track {
    // Update the UI
    NSString *trackString = [NSString stringWithFormat:@"%@ on %@ by %@", [track name], [track album], [track artist]];
    [_currentTrackItem setTitle: trackString];
    
    // Send it to the server
    [[self server] sendTrack: track];
}

-(void) quit: (id)sender {
    [[NSApplication sharedApplication] terminate: sender];
}

@end
