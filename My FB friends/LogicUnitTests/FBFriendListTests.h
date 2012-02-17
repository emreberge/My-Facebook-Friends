//
//  FBFriendListTests.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FBFriendList.h"

@interface FBFriendListTests : SenTestCase
{
    FBFriendList* fbFriendList;
    id personJSON;
}

@end

@interface FBFriendList(test)
- (NSString*) nameFromPersonJSON:(id) personJSON;
@end