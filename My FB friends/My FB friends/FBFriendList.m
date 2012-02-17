//
//  FBFriendList.m
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import "FBFriendList.h"

@implementation FBFriendList

- (id) initWithFriendsJSON:(id) friendsJSON
{
    if(self = [super init]) {
        friends = [friendsJSON valueForKey:@"data"];
        [friends retain];
    }
    return self;
}

- (NSString*) nameFromPersonJSON:(id) personJSON
{
    return [personJSON valueForKey:@"name"];
}

- (NSString*) getNameAtIndex:(NSInteger) index
{
    return [self nameFromPersonJSON:[friends objectAtIndex:index]];
}

- (NSURL*) getProfilePictureURLAtIndex:(NSInteger) index
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[[friends objectAtIndex:index] valueForKey:@"id"] ]];
}

- (NSInteger) numberOfFriends
{
    return [friends count];
}

- (void)dealloc {
    [friends release];
    [super dealloc];
}
@end
