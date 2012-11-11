//
//  ServerDelegate.h
//  Riffrat
//
//  Created by Steve Gattuso on 11/10/12.
//  Copyright (c) 2012 Riffrat. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerDelegate <NSObject>

@optional
-(void) authenticateDidFinish: (NSDictionary *) response;
-(void) authenticateDidFail: (NSNumber *) responseCode;
-(void) listenDidFinish;

@end
