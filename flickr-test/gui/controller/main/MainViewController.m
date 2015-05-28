//
//  MainViewController.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "MainViewController.h"

#import "ImageListViewController.h"
#import "PhotoProvider.h"
#import "HudHelper.h"

#import "AlertHelper.h"
#import "ErrorHelper.h"

@interface MainViewController(){
   
}

@property ( readwrite) ImageListViewController *imageListViewController;;
@end

@implementation MainViewController


-(void)viewDidLoad{
   [super viewDidLoad];
   //setup image list container
   self.imageListViewController = [[ImageListViewController alloc] init];
   self.viewControllers = @[ self.imageListViewController];
   [HudHelper showHudOverView: self.view];
   __block __typeof( self) weakSelf = self;
   [PhotoProvider photoListWithTag: @"party"
                            finish:^(NSArray *list) {
                               __strong __typeof( weakSelf) strongSelf = weakSelf;
                               if( strongSelf){
                                  [HudHelper hideHudOverView: strongSelf.view];
                                  NSString *msg = [NSString stringWithFormat:@"Found %ld photo(s)", (long)list.count];
                                  [AlertHelper showAlertWithOnlyOkUsingTitle: @"Ok" message:msg];
                                  [strongSelf.imageListViewController reloadDataUsingImageBeanList: list];
                               }
                            } error:^(NSError *error) {
                               __strong __typeof( weakSelf) strongSelf = weakSelf;
                               if( strongSelf){
                                  [HudHelper hideHudOverView: strongSelf.view];
                                  [AlertHelper showAlertWithOnlyOkUsingTitle: @"Error"
                                                                     message: [ErrorHelper errorMessage: error]];
                               }
                            }];
   
}

@end
