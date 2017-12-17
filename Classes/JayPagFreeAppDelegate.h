//
//  JayPagFreeAppDelegate.h
//  JayPagFree
//
//  Created by Carlo Macor on 29/01/10.
//  Copyright Carlo Macor 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JayPagFreeViewController;

@interface JayPagFreeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    JayPagFreeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JayPagFreeViewController *viewController;

@end

