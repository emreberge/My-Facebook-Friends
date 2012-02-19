//
//  NSDictionary+FBFriendList.m
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import "NSDictionary+FBFriendList.h"

@implementation NSDictionary (FBFriendList)

- (NSString *)name
{
    return [self valueForKey:@"name"];
}

- (NSURL *)profilePictureURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[self valueForKey:@"id"] ]];
}

- (NSArray *) friendsFromJSON
{
    return [self valueForKey:@"data"];
}

@end
