//
//  MyFriendsListTableController.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+FBFriendList.h"

@interface MyFriendsListTableController : UITableViewController
{
    @private
    NSArray *_fbFriends;
}

- (void)setDisplayedFriends:(NSArray *) fbFriends;

@end
