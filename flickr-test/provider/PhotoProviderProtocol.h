//
//  PhotoProviderProtocol.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 protocol to retrieve photos
*/
@protocol PhotoProviderProtocol <NSObject>

/*
 retrieve photos with specific tag(s)
*/
-( void)photoListWithTag:( NSString *)tag
                  finish:( void (^) ( NSArray *))finishBlock
                   error:( void( ^)( NSError *)) errorBlock;

@end
