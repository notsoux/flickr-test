//
//  HudHelper.h
//  fwk-app-test
//
//  Created by William Pompei on 27/11/14.
//  Copyright (c) 2014 App&Map. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 helper to show/hide hud
*/
@interface HudHelper : NSObject

+( void)showHudOverView:( UIView *)view;
+( void)hideHudOverView:( UIView *)view;

@end
