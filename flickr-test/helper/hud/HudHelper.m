//
//  HudHelper.m
//  fwk-app-test
//
//  Created by William Pompei on 27/11/14.
//  Copyright (c) 2014 App&Map. All rights reserved.
//

#import "HudHelper.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation HudHelper


+( void)showHudOverView:( UIView *)view{
   if( [NSThread isMainThread]){
      [MBProgressHUD showHUDAddedTo: view animated: YES];
   } else {
      dispatch_sync( dispatch_get_main_queue(), ^{
         [MBProgressHUD showHUDAddedTo: view animated: YES];
      });
   }
}

+( void)hideHudOverView:( UIView *)view{
   if( [NSThread isMainThread]){
      [MBProgressHUD hideAllHUDsForView: view animated: YES];
   } else {
      dispatch_sync( dispatch_get_main_queue(), ^{
         [MBProgressHUD hideAllHUDsForView: view animated: YES];
      });
   }
}

@end
