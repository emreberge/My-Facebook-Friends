//
//  FBFriendList.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFriendList : NSObject
{
    id friends;
}

- (id) initWithFriendsJSON:(id) friends;
- (NSString*) getNameAtIndex:(NSInteger) index;
- (NSURL*) getProfilePictureURLAtIndex:(NSInteger) index;

@end
