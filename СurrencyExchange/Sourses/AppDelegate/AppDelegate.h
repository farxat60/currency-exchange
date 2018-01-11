//
//  AppDelegate.h
//  currencies
//
//  Created by Joe Franc on 12/26/17.
//  Copyright © 2017 Joe Franc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;


@end

