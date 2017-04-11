//
//  AppDelegate.m
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "AppDelegate.h"
#import "OnboardViewController.h"
#import "PageViewController.h"

@import Firebase;
@import UserNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate, FIRMessagingDelegate>

@end

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Register for remote notifications
    // Show permission
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
         if (error) {
             NSLog(@"Error requesting notif auth: %@", error.localizedDescription);
         }
         if (granted) {
             NSLog(@"Permission granted!");
         }
     }];
    
    [FIRMessaging messaging].remoteMessageDelegate = self;
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    // Observe for token refresh with callback
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(tokenRefreshNotif:)
     name:kFIRInstanceIDTokenRefreshNotification object:nil];
    
    [FIRApp configure];
    
    UIViewController *root = [OnboardViewController initOnboardViewControllerFromStoryboard];
    if ([[FIRAuth auth] currentUser]) {
        root = [PageViewController initPageViewControllerFromStoryboard];
    }
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - FCM

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID %@", userInfo[kGCMMessageIDKey]);
    }
    
    NSLog(@"didReceiveRemoteNotification: %@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - UNUserNotificationDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    // Print message ID.
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"willpresentNotification Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"will presentPresentNotification: %@", userInfo);
    NSDictionary *alert = userInfo[@"aps"][@"alert"];
    
    // Present alert
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:alert[@"title"] message:alert[@"body"]
                                          preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"didReceiveNotificationResponse Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"didReceiveNotificationResponse: %@", userInfo);
    
    completionHandler();
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for APN: %@", error);
}

#pragma mark - FirMessagingDelegate

- (void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    // Receive message when app is in foreground
    NSLog(@"applicationReceivedRemoteMessage message: %@", remoteMessage.appData);
}

- (void)tokenRefreshNotif:(NSNotification *)notification {
    // Called when a new token is created
    NSString *refreshToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceId token created: %@", refreshToken);
    
    // Connect to FCM
    [self connectToFcm];
    
    // Update server with new token
}

- (void)connectToFcm {
    // if no token don't connect
    if (![[FIRInstanceID instanceID] token]) {
        return;
    }
    
    // Disconnect prevoius FCM connection
    [[FIRMessaging messaging] disconnect];
    
    // Connect
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Could not connect to FCM: %@", error);
        } else NSLog(@"Connected to FCM!");
    }];
}

#pragma mark - State

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[FIRMessaging messaging] disconnect];
    NSLog(@"App went into background! Disconnect FCM");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self connectToFcm];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
