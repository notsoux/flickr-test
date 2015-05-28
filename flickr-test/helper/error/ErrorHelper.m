//
//  ErrorHelper.m
//  flickr-test
//
//  Created by William Pompei on 28/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "ErrorHelper.h"

@implementation ErrorHelper

NSInteger const ERROR_CODE_IMAGE_NOT_FOUND = -1;
NSInteger const ERROR_CODE_CONNECTION_ERROR = -2;
NSInteger const ERROR_CODE_FLICKR_API = -3;
NSInteger const ERROR_CODE_DOWNLOAD_IMAGE_SIZE_UNKNOWN = -4;

+( NSError *)errrorUsingCode:( NSInteger) errorCode
                      mesage:( NSString *) message{
   NSError *error = [NSError errorWithDomain: @"TEST_DOMAIN"
                                        code: errorCode
                                    userInfo:@{@"message": message}];
   return error;
}

+( NSString *)errorMessage:( NSError *)error{
   NSString *message;
   switch ( error.code) {
      case ERROR_CODE_IMAGE_NOT_FOUND:
      case ERROR_CODE_CONNECTION_ERROR:
      case ERROR_CODE_FLICKR_API:
      case ERROR_CODE_DOWNLOAD_IMAGE_SIZE_UNKNOWN:{
         message = error.userInfo[@"message"];
         break;
      }
         
      default:{
         message = error.description;
         break;
      }
   }
   return message;
}

@end
