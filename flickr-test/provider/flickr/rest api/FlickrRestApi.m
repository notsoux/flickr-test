//
//  FlickrRestApi.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "FlickrRestApi.h"
#import "AFNetworking.h"

#import "ConfigurationHelper.h"

@implementation FlickrRestApi

#define TAG_LIST @"%TAG_LIST%"
#define FLICKR_API_KEY @"%FLICKR_API_KEY%"
#define PHOTO_FILTERED_BY_TAGS_URL @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="FLICKR_API_KEY"&format=json&nojsoncallback=1&tags="TAG_LIST


+( void)photoListFilteredByTags:( NSArray *)tagList
                         finish:( void (^) ( NSDictionary *))finishBlock
                          error:( void( ^)( NSError *)) errorBlock{
   NSString *tagListAsString = [tagList componentsJoinedByString: @","];
   NSString*urlAsString = [PHOTO_FILTERED_BY_TAGS_URL stringByReplacingOccurrencesOfString: TAG_LIST withString: tagListAsString];
   urlAsString = [urlAsString stringByReplacingOccurrencesOfString: FLICKR_API_KEY withString:[ ConfigurationHelper flickrApiKey]];
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   [manager GET: urlAsString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      if( finishBlock != nil){
         finishBlock( responseObject);
      }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      if( errorBlock != nil){
         NSLog( @"Error -> %@", error );
         errorBlock( error);
      }
   }];
}

@end
