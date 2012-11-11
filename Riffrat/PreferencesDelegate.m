//
//  PreferencesDelegate.m
//  Riffrat
//
//  Created by Steve Gattuso on 11/10/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import "PreferencesDelegate.h"

@implementation PreferencesDelegate

-(id) init {
    self = [super init];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    return self;
}

-(void) applicationDidFinishLoading:(NSNotification *)aNotification {
    if([userDefaults objectForKey:@"email"] != nil && [userDefaults objectForKey:@"password"] != nil) {
        [emailField setStringValue: [userDefaults objectForKey: @"email"]];
        [passwordField setStringValue: [userDefaults objectForKey:@"password"]];
        [self pressLogin: nil];
    }
}

-(void) setServer: (Server *) in_server {
    server = in_server;
    [server setAuthDelegate: self];
}
-(IBAction) showPreferencesWindow:(id)sender {
    [window makeKeyAndOrderFront: sender];
}

-(IBAction) pressLogin:(id) sender {
    NSString *email = [emailField stringValue];
    NSString *password = [passwordField stringValue];
    
    // Start the spinner
    [spinner setHidden: NO];
    [spinner startAnimation: sender];
    
    // Send it to the server
    [server authenticateWithEmail: email  andPassword: password];
}

-(void) authenticateDidFinish:(NSDictionary *)response {
    // Either way let's stop the spinner and hide both statuses
    [spinner stopAnimation: self];
    [spinner setHidden: YES];
    [badAuthLabel setHidden: YES];
    [authSuccessImage setHidden: YES];
    
    // Was there an error?
    if(![[response objectForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt: 1]]) {
        [badAuthLabel setHidden: NO];
        return;
    }
    
    // Nope, so let's show an authentication success image
    [authSuccessImage setHidden: NO];
    
    // Store the correct credentials
    [userDefaults setObject: [response objectForKey: @"sid"] forKey:@"sid"];
    [userDefaults setObject: [emailField stringValue] forKey:@"email"];
    [userDefaults setObject: [passwordField stringValue] forKey:@"password"];
}

@end
