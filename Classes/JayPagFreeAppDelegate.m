//
//  JayPagFreeAppDelegate.m
//  JayPagFree
//
//  Created by Carlo Macor on 29/01/10.
//  Copyright Carlo Macor 2010. All rights reserved.
//

#import "JayPagFreeAppDelegate.h"
#import "JayPagFreeViewController.h"

@implementation JayPagFreeAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

// Invoked immediately before the application terminates.
- (void)applicationWillTerminate:(UIApplication *)application {
	[viewController   fissavariabili];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
