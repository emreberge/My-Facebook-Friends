//
//  AppDelegate.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/1/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "MyFriendsListTableController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyFriendsListTableController *myFriendsListTableController;
@property (nonatomic, retain) Facebook *facebook;

@end
