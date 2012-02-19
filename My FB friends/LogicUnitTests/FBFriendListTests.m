//
// Copyright 2012 Emre Berge Ergenekon
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
