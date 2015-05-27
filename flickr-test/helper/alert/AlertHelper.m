//
//  AlertHelper.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "AlertHelper.h"
#import <UIKit/UIKit.h>

@implementation AlertHelper

+( void)showAlertWithOnlyOkUsingTitle:( NSString *)title
                              message:( NSString *)message{
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                   message: message
                                                  delegate: nil
                                         cancelButtonTitle: @"Ok"
                                         otherButtonTitles: nil];
   [alert show];
}

@end
