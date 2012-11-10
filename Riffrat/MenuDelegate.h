//
//  AppDelegate.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/8/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ListenManagerDelegate.h"
#import "Track.h"

@interface MenuDelegate : NSObject <ListenManagerDelegate>

@property (assign) IBOutlet NSMenu *menu;
@property (assign) IBOutlet NSMenuItem *currentTrackItem;
@property (strong) NSStatusItem *statusItem;

-(IBAction) quit: (id) sender;
-(void) updateTrack: (Track *)track;

@end
