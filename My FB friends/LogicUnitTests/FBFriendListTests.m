//
//  FBFriendListTests.m
//  My FB friends
//
//  Created by Emre Ergenekon on 2/8/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import "FBFriendListTests.h"
#import "AFJSONUtilities.h"
#import "NSDictionary+FBFriendList.h"


#define kExampleFBFriendsJSON @"{ \"data\": [{\"name\": \"Adam Smith\", \"id\": \"1201503\"},{\"name\": \"George Lucas\", \"id\": \"5123512\"},{\"name\": \"Erlang Pascal\",\"id\": \"1241245123\"}],\"paging\": {\"next\": \"https://graph.facebook.com/688752050/friends?format=json&limit=500&offset=500&__after_id=100202253318773\"}}"

#define kExampleFBPersonJSON @"{\"name\": \"Adam Smith\", \"id\": \"1201503\"}"

@implementation FBFriendListTests

- (id)jsonFromString:(NSString*) string
{
    NSError *error = nil;
    return AFJSONDecode([string dataUsingEncoding:NSUTF8StringEncoding], &error);
}

- (void)setUp
{
    [super setUp];
    id friendsJSON = [self jsonFromString:kExampleFBFriendsJSON];
    STAssertNotNil(friendsJSON, @"Could not create an JSON Friends object");
        
    fbFriends = [[friendsJSON friendsFromJSON] retain];
    STAssertNotNil(fbFriends, @"Failed to create fbFriends object");
}

- (void)tearDown
{
    [fbFriends release];
    [super tearDown];
}

- (void)testInit
{
    // Intentionaly empty to trigger a setUp.
}

- (void)testNames
{
    STAssertEqualObjects([[fbFriends objectAtIndex:0] name],  @"Adam Smith",@"");
    STAssertEqualObjects([[fbFriends objectAtIndex:1] name],  @"George Lucas",@"");
    STAssertEqualObjects([[fbFriends objectAtIndex:2] name],  @"Erlang Pascal",@"");

}

- (void)testProfilePictureURLs
{
    STAssertEqualObjects([[fbFriends objectAtIndex:0] profilePictureURL], [NSURL URLWithString:@"https://graph.facebook.com/1201503/picture"], @"");
    STAssertEqualObjects([[fbFriends objectAtIndex:1] profilePictureURL], [NSURL URLWithString:@"https://graph.facebook.com/5123512/picture"], @"");
    STAssertEqualObjects([[fbFriends objectAtIndex:2] profilePictureURL], [NSURL URLWithString:@"https://graph.facebook.com/1241245123/picture"], @"");
}

- (void)testNumberOfFriends
{
    STAssertEquals([fbFriends count], (NSUInteger)3, @"");
}

@end
