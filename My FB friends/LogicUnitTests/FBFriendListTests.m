//
//  FBFriendListTests.m
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import "FBFriendListTests.h"
#import "AFJSONUtilities.h"

#define kExampleFBFriendsJSON @"{ \"data\": [{\"name\": \"Adam Smith\", \"id\": \"1201503\"},{\"name\": \"George Lucas\", \"id\": \"5123512\"},{\"name\": \"Erlang Pascal\",\"id\": \"1241245123\"}],\"paging\": {\"next\": \"https://graph.facebook.com/688752050/friends?format=json&limit=500&offset=500&__after_id=100202253318773\"}}"

@implementation FBFriendListTests

- (void)setUp
{
    [super setUp];
    NSError *error = nil;
    id friendsJSON = AFJSONDecode([kExampleFBFriendsJSON dataUsingEncoding:NSUTF8StringEncoding], &error);
    STAssertNotNil(friendsJSON, @"Could not create an JSON object");
    NSLog(@"%@", kExampleFBFriendsJSON);
    fbFriendList = [[[FBFriendList alloc] initWithFriendsJSON:friendsJSON] retain];
    STAssertNotNil(fbFriendList, @"Failed to create FBFriendsList object");
}

- (void)tearDown
{
    [fbFriendList release];
    [super tearDown];
}

- (void)testInit
{
    // Intentionaly empty to trigger a setUp.
}

- (void)testGetNameAtIndex
{
    STAssertEqualObjects([fbFriendList getNameAtIndex:0],  @"Adam Smith",@"");
    STAssertEqualObjects([fbFriendList getNameAtIndex:1],  @"George Lucas",@"");
    STAssertEqualObjects([fbFriendList getNameAtIndex:2],  @"Erlang Pascal",@"");

}

- (void)testGetProfilePictureURLAtIndex
{
    STAssertEqualObjects([fbFriendList getProfilePictureURLAtIndex:0], [NSURL URLWithString:@"https://graph.facebook.com/1201503/picture"], @"");
    STAssertEqualObjects([fbFriendList getProfilePictureURLAtIndex:1], [NSURL URLWithString:@"https://graph.facebook.com/5123512/picture"], @"");
    STAssertEqualObjects([fbFriendList getProfilePictureURLAtIndex:2], [NSURL URLWithString:@"https://graph.facebook.com/1241245123/picture"], @"");
}

- (void)testNumberOfFriends
{
    STAssertEquals([fbFriendList numberOfFriends], 3, @"");
}

@end
