//
//  FlickrProvider.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "FlickrProvider.h"

#import "FlickrRestApi.h"
#import "ImageBean.h"

#import "ErrorHelper.h"

@implementation FlickrProvider

#pragma mark - protocol implementation
+ (NSArray *)parsePhotoListFlickrResponse:(NSDictionary *)jsonDict{
   NSArray *images = jsonDict[ @"photos"][ @"photo"];
   NSMutableArray *imageList = [[NSMutableArray alloc] init];
   [images enumerateObjectsUsingBlock:^( NSDictionary *imageDict, NSUInteger idx, BOOL *stop) {
      ImageBean *imageBean = [FlickrProvider imageBeanFromJson: imageDict];
      [imageList addObject: imageBean];
   }];
   return [imageList copy];
}

-( void)photoListWithTag:( NSString *)tag
                  finish:(void (^)(NSArray *))finishBlock
                   error:(void (^)(NSError *))errorBlock{
   [FlickrRestApi photoListFilteredByTags: @[tag] finish:^(NSDictionary *jsonDict) {
      NSString *stat = jsonDict[@"stat"];
      if( [stat isEqualToString:@"fail"]){
         if( errorBlock){
            NSError *error = [ErrorHelper errrorUsingCode: ERROR_CODE_FLICKR_API mesage: @"Problems with Flickr api call"];
            errorBlock( error);
            return;
         }
      }
      NSArray *imageList = [FlickrProvider parsePhotoListFlickrResponse:jsonDict];
      if( finishBlock != nil){
         finishBlock( imageList);
      }
      
   } error:^(NSError *error) {
      if( errorBlock != nil){
         //afnetworking error code here
         errorBlock( error);
      }
   }];
}

#pragma mark - json parsing
#define FLICKR_IMAGE_URL @"https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{size}.jpg"

+( ImageBean *)imageBeanFromJson:( NSDictionary *)jsonDict{
   //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
   //{"id":"17503400914","owner":"23151904@N02","secret":"5ebb30071b","server":"7768","farm":8,"title":"Her 31st","ispublic":1,"isfriend":0,"isfamily":0}
   NSNumber *farmId = jsonDict[ @"farm"];
   NSString *serverId = jsonDict[ @"server"];
   NSString *photoId = jsonDict[ @"id"];
   NSString *secret = jsonDict[ @"secret"];
   NSString *title = jsonDict[ @"title"];
   NSString *imageUrlAsString = [FLICKR_IMAGE_URL stringByReplacingOccurrencesOfString: @"{farm-id}" withString: farmId.stringValue];
   imageUrlAsString = [imageUrlAsString stringByReplacingOccurrencesOfString: @"{server-id}" withString: serverId];
   imageUrlAsString = [imageUrlAsString stringByReplacingOccurrencesOfString: @"{id}" withString: photoId];
   imageUrlAsString = [imageUrlAsString stringByReplacingOccurrencesOfString: @"{secret}" withString: secret];
   NSString *smallImageUrlAsString = [imageUrlAsString stringByReplacingOccurrencesOfString: @"{size}" withString: @"m"];
   NSString *largeImageUrlAsString = [imageUrlAsString stringByReplacingOccurrencesOfString: @"{size}" withString: @"b"];
   
   NSURL *smallImageUrl = [NSURL URLWithString: smallImageUrlAsString];
   NSURL *largeImageUrl = [NSURL URLWithString: largeImageUrlAsString];
   ImageBean *imageBean = [[ImageBean alloc] initUsingSmallImageURL: smallImageUrl
                                                      largeImageUrl: largeImageUrl
                                                         identifier: photoId
                                                              title: title];
   
   return imageBean;
   
}

@end
