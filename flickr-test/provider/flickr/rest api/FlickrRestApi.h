//
//  FlickrRestApi.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 flickr rest api support
*/
@interface FlickrRestApi : NSObject

/*
 get all photos with tag(s) contained in tagList
*/
+( void)photoListFilteredByTags:( NSArray *)tagList
                         finish:( void (^) ( NSDictionary *))finishBlock
                          error:( void( ^)( NSError *)) errorBlock;

@end
