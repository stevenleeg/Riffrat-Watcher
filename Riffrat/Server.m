//
//  Server.m
//  Riffrat
//
//  Created by Steve Gattuso on 11/10/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import "Server.h"

@implementation Server

@synthesize authDelegate;

-(id) init {
    self = [super init];
    
    // We're not authenticated
    [self setAuthenticated: [NSNumber numberWithInt: 0]];
    
    // Change this for debugging purposes
    _baseURL = @"http://localhost:5000/";
    
    return self;
}

-(void) authenticateWithEmail:(NSString *)email andPassword:(NSString *)password {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@api/1.0/authenticate", _baseURL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: url];
    
    [request setPostValue: email forKey:@"email"];
    [request setPostValue: password forKey:@"password"]; // TODO: Encrypt this!
    [request setDelegate: self];
    [request setDidFinishSelector: @selector(authenticateDidFinish:)];
    [request setDidFailSelector: @selector(requestError:)];
    [request startAsynchronous];
    
    NSLog(@"[auth] Authenticating...");
}

-(void)authenticateDidFinish:(ASIHTTPRequest *)request {
    // Parse the JSON
    NSDictionary *response = [[request responseString] JSONValue];
    
    if([[response valueForKey:@"status"] isEqualToNumber: [NSNumber numberWithInt: 1]]) {
        NSLog(@"[auth] Success");
        [self setAuthenticated: [NSNumber numberWithInt:1]];
    }
    else {
        NSLog(@"[auth] Error. (%@)", [response valueForKey:@"status"]);
        [self setAuthenticated: [NSNumber numberWithInt: 0]];
    }
    
    // Notify the delegate
    if([[self authDelegate] respondsToSelector: @selector(authenticateDidFinish:)])
        [[self authDelegate] authenticateDidFinish: response];
}

-(void)requestError: (ASIHTTPRequest*) request {
    NSLog(@"[server] There was an error with a request");
}

@end
