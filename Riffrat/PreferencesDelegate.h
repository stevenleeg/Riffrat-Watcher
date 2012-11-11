//
//  PreferencesDelegate.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/10/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerDelegate.h"
#import "Server.h"

@interface PreferencesDelegate : NSObject <ServerDelegate> {
    IBOutlet NSWindow *window;
    IBOutlet NSProgressIndicator *spinner;
    IBOutlet NSTextField *emailField;
    IBOutlet NSTextField *passwordField;
    IBOutlet NSTextField *badAuthLabel;
    IBOutlet NSImageView *authSuccessImage;
    Server *server;
    NSWindowController *wc;
    NSUserDefaults *userDefaults;
}

-(void) applicationDidFinishLoading: (NSNotification *) aNotification;
-(void) setServer: (Server *)in_server;
-(IBAction) pressLogin: (id) sender;
-(IBAction) showPreferencesWindow: (id) sender;

@end
