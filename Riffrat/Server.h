//
//  Server.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/10/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "ServerDelegate.h"

@interface Server : NSObject

@property NSNumber *authenticated;
@property NSString *baseURL;
@property (retain) id <ServerDelegate> authDelegate;
@property (retain) id <ServerDelegate> listenDelegate;

-(void) authenticateWithEmail: (NSString*) username andPassword: (NSString *) password;
-(void) authenticateDidFinish: (ASIHTTPRequest *) request;
-(void) requestError: (ASIHTTPRequest *) request;

@end
