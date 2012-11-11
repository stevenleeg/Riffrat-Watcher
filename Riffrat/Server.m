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
@synthesize listenDelegate;
@synthesize sid;

-(id) init {
    self = [super init];
    
    // We're not authenticated
    [self setAuthenticated: [NSNumber numberWithInt: 0]];
    
    // Change this for debugging purposes
    _baseURL = @"http://riffrat.com/";
    
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
        [self setSid: [response objectForKey:@"sid"]];
    }
    else {
        NSLog(@"[auth] Error. (%@)", [response valueForKey:@"status"]);
        [self setAuthenticated: [NSNumber numberWithInt: 0]];
    }
    
    // Notify the delegate
    if([[self authDelegate] respondsToSelector: @selector(authenticateDidFinish:)])
        [[self authDelegate] authenticateDidFinish: response];
}

-(void) sendTrack:(Track *)track {
    // If the track has been sent, stop
    if([[track sent] isEqualToNumber:[NSNumber numberWithInt:1]])
        return;
    // If we're not authenticated, stop.
    if([[self authenticated] isEqualToNumber:[NSNumber numberWithInt:0]])
        return;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@api/1.0/write", _baseURL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: url];
    
    [request setPostValue: [track artist] forKey:@"artist"];
    [request setPostValue: [track album] forKey:@"album"];
    [request setPostValue: [track name] forKey:@"name"];
    [request setPostValue: [self sid] forKey:@"sid"];
    
    [request setDelegate: self];
    [request setDidFinishSelector: @selector(sendTrackDidFinish:)];
    [request setDidFailSelector: @selector(requestError:)];
    [request startAsynchronous];
    
    // Mark the track as sent
    [track setSent: [NSNumber numberWithInt:1]];
    
    NSLog(@"[write] Sending track...");
}

-(void) sendTrackDidFinish:(ASIHTTPRequest *)request {
    NSDictionary *response = [[request responseString] JSONValue];
    if(![[response objectForKey:@"status"] isEqualToNumber: [NSNumber numberWithInt:1]]) {
        NSLog(@"[write] Failed with error %@", [response objectForKey:@"error"]);
        NSLog(@"[write] Resp: %@", [request responseString]);
        return;
    }
    
    if([[self listenDelegate] respondsToSelector:@selector(sendTrackDidFinish:)])
        [[self listenDelegate] sendTrackDidFinish: response];
    
    NSLog(@"[write] Success.");
}

-(void)requestError: (ASIHTTPRequest*) request {
    NSLog(@"[server] There was an error with a request");
}

@end
