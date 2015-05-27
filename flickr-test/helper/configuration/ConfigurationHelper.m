//
//  ConfigurationHelper.m
//  flickr-test
//
//  Created by William Pompei on 27/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "ConfigurationHelper.h"

@implementation ConfigurationHelper

static NSDictionary *__static_ConfigurationHelper_params;

+( void)initialize{
   NSString *path = [[NSBundle mainBundle] pathForResource:@"configuration" ofType:@"plist"];
   __static_ConfigurationHelper_params = [[NSDictionary alloc] initWithContentsOfFile:path];
}

+( NSString *)flickrApiKey{
   NSString *value = __static_ConfigurationHelper_params[@"flickr_api_key"];
   return value;
}

@end
