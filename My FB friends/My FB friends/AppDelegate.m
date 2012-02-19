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

#import "AppDelegate.h"
#import "AFJSONRequestOperation.h"
#import "NSDictionary+FBFriendList.h"

@interface AppDelegate()

- (void)setFBListForMyfriendsListTableController;

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize myFriendsListTableController = _myFriendsListTableController;
@synthesize facebook = _facebook;

- (void)dealloc
{
    [_window release];
    [_myFriendsListTableController release];
    [_facebook release];
    [super dealloc];
}

- (void)checkUserDefaultsForFacebookAccessToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
}

- (void) makeSureFacebookSessionIsValid
{
    if (![self.facebook isSessionValid]) {
        [self.facebook authorize:nil];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.facebook = [[[Facebook alloc] initWithAppId:@"379633892050184" andDelegate:self] autorelease];
    [self checkUserDefaultsForFacebookAccessToken];
    [self makeSureFacebookSessionIsValid];
    [self setFBListForMyfriendsListTableController];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.myFriendsListTableController = [[[MyFriendsListTableController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    self.window.rootViewController = self.myFriendsListTableController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

// Pre 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url]; 
}

// For 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url]; 
}

#pragma mark - FBSessionDelegate

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.facebook.accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:self.facebook.expirationDate forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self setFBListForMyfriendsListTableController];
}

- (void)fbDidNotLogin:(BOOL)cancelled
{

}

- (void)fbDidLogout
{
    
}

-(void)fbSessionInvalidated
{
    
}

- (void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    
}

#pragma mark - Private methods

- (void)setFBListForMyfriendsListTableController
{
    if([self.facebook accessToken]) {
        NSURL *url = [NSURL URLWithString:[@"https://graph.facebook.com/me/friends?access_token=" stringByAppendingString:self.facebook.accessToken]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [self.myFriendsListTableController setDisplayedFriends:[JSON friendsFromJSON]];
        } failure:nil];
        
        [operation start];
    }

}


@end
