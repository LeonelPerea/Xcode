//
//  AppDelegate.m
//  camaraFotografica
//
//  Created by Leonel Roberto Perea Trejo on 24/10/12.
//  Copyright (c) 2012 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate
@synthesize window;
@synthesize viewController;
@synthesize manageObjectContext;
@synthesize manageObjectModel;
@synthesize persistentStoreCoordinator;

- (void) saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.manageObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@ "Error no resuelto %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

- (NSManagedObjectContext *) manageObjectContext{
    if (manageObjectContext != nil) {
        return manageObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        manageObjectContext = [[NSManagedObjectContext alloc]init];
        [manageObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return manageObjectContext;
}

-(NSPersistentStoreCoordinator *) persistentStoreCoordinator{
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"datos.sqlite"];
    NSError * error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self manageObjectModel]];
    if ([persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@ "Error no resuelto %@, %@", error, [error userInfo]);
        abort();
    }
    return persistentStoreCoordinator;
}

-(NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask]lastObject];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Override point for customization after app launch
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
