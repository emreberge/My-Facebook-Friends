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
        friends = [[friendsJSON retain] valueForKey:@"data"];
    }
    return self;
}

- (NSString*) getNameAtIndex:(NSInteger) index
{
    return [[friends objectAtIndex:index] valueForKey:@"name"];
}

- (void)dealloc {
    [friends release];
    [super dealloc];
}
@end
