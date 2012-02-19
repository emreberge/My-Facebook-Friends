//
//  NSDictionary+FBFriendList.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FBFriendList)

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *profilePictureURL;

- (NSArray *) friendsFromJSON;

@end