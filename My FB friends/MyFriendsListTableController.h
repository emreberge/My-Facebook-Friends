//
//  MyFriendsListTableController.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFriendList.h"

@interface MyFriendsListTableController : UITableViewController

@property (nonatomic, retain) FBFriendList *fbFriendList;

@end