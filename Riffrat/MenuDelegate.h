//
//  AppDelegate.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/8/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ListenManagerDelegate.h"
#import "PreferencesDelegate.h"
#import "ListenManager.h"
#import "Track.h"
#import "Server.h"

@interface MenuDelegate : NSObject <ListenManagerDelegate, ServerDelegate> {
    IBOutlet PreferencesDelegate *preferencesDelegate;
    IBOutlet ListenManager *listenManager;
}

@property (assign) IBOutlet NSMenu *menu;
@property (assign) IBOutlet NSMenuItem *currentTrackItem;
@property (strong) NSStatusItem *statusItem;
@property (strong) Server *server;

-(IBAction) quit: (id) sender;
-(void) updateTrack: (Track *)track;

@end
