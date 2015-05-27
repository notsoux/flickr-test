//
//  PhotoProvider.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "PhotoProvider.h"

#import "PhotoProviderProtocol.h"
#import "FlickrProvider.h"

@interface PhotoProvider(){
   
}
@end

@implementation PhotoProvider

static id<PhotoProviderProtocol> __static__PhotoProvider_photoProvider;

/*
 in this demo only flickr provider is used, but it's possible
 to use another provider ( ex. LocalProvider - which can get images from assets)
 and let user choose which one she prefers
*/
+( void)initialize{
   __static__PhotoProvider_photoProvider = [[FlickrProvider alloc] init];
}

/*
 retrieve photo(s) using flickr provider
*/
+( void)photoListWithTag:( NSString *)tag
                  finish:( void (^) ( NSArray *))finishBlock
                   error:( void( ^)( NSError *)) errorBlock{
   [__static__PhotoProvider_photoProvider photoListWithTag: tag
                                                    finish:^(NSArray *list) {
                                                       if( finishBlock){
                                                          finishBlock( list);
                                                       }
                                                    } error:^(NSError *error) {
                                                       if( errorBlock){
                                                          errorBlock( error);
                                                       }
                                                    }];
   
}

@end
