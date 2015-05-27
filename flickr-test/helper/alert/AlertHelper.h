//
//  AlertHelper.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 helper with common AlertView operations
*/
@interface AlertHelper : NSObject

+( void)showAlertWithOnlyOkUsingTitle:( NSString *)title
                              message:( NSString *)message;

@end
