//
//  ErrorHelper.h
//  flickr-test
//
//  Created by William Pompei on 28/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorHelper : NSObject

extern NSInteger const ERROR_CODE_IMAGE_NOT_FOUND;
extern NSInteger const ERROR_CODE_CONNECTION_ERROR;
extern NSInteger const ERROR_CODE_FLICKR_API;
extern NSInteger const ERROR_CODE_DOWNLOAD_IMAGE_SIZE_UNKNOWN;

+( NSError *)errrorUsingCode:( NSInteger) errorCode
                      mesage:( NSString *) message;

/*
 get error message from userInfo[@"message"] if defined,
 otherwise error.description is reurned
 */
+( NSString *)errorMessage:( NSError *)error;

@end
