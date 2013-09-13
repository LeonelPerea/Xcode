//
//  AppDelegate.h
//  camaraFotografica
//
//  Created by Leonel Roberto Perea Trejo on 24/10/12.
//  Copyright (c) 2012 Leonel Roberto Perea Trejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    ViewController *viewController;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, readonly, retain) NSManagedObjectContext *manageObjectContext;
@property (nonatomic, readonly, retain) NSManagedObjectModel *manageObjectModel;
@property (nonatomic, readonly, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) saveContext;
-(NSURL *) applicationDocumentsDirectory;

@end
