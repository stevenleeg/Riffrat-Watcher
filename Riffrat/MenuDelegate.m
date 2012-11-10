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
}

-(void) updateTrack:(Track *)track {
    NSString *trackString = [NSString stringWithFormat:@"%@ on %@ by %@", [track name], [track album], [track artist]];
    [_currentTrackItem setTitle: trackString];
}

-(void) quit: (id)sender {
    [[NSApplication sharedApplication] terminate: sender];
}

@end
