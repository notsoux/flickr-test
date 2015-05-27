//
//  AsynchImageDownloader.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "AsynchImageDownloader.h"

#import "AFNetworking.h"

@implementation AsynchImageDownloader


+( void)asynchDownload:( ImageBean *)imageBean
          downloadSize:( DOWNLOAD_IMAGE_SIZE_ENUM)downloadSize
                finish:( void (^) ( DownloadedImageBean *))finishBlock
                 error:( void( ^)( NSError *)) errorBlock{
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   manager.responseSerializer = [[AFImageResponseSerializer alloc] init];
   
   NSString *downloadUrlAsString;
   switch( downloadSize){
      case DOWNLOAD_IMAGE_SIZE_SMALL:{
         downloadUrlAsString = [imageBean.smallImageUrl absoluteString];
         break;
      }
      case DOWNLOAD_IMAGE_SIZE_LARGE:{
         downloadUrlAsString = [imageBean.largeImageUrl absoluteString];
         break;
      }
      default:{
         if( errorBlock){
            NSError *error = [NSError errorWithDomain: @"TEST_DOMAIN"
                                                 code:-1
                                             userInfo:@{@"message": @"image size unknown"}];
            errorBlock( error);
         }
         return;
      }
   }
   
   [manager GET: downloadUrlAsString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      UIImage *image = ( UIImage *)responseObject;
      DownloadedImageBean *downloadedIamgeBean = [[DownloadedImageBean alloc] initUsingImageBean: imageBean image:image];
      if( finishBlock){
         finishBlock( downloadedIamgeBean);
      }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Error: %@", error);
      if( errorBlock){
         errorBlock( error);
      }
   }];
   
}

@end
