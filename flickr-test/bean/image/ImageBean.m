//
//  ImageBean.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "ImageBean.h"

@interface ImageBean(){
   
}

@property ( strong, readwrite) NSURL *smallImageUrl;
@property ( strong, readwrite) NSURL *largeImageUrl;
@property ( strong, readwrite) NSString *identifier;
@property ( strong, readwrite) NSString *title;

@end

@implementation ImageBean

-( id)initUsingSmallImageURL:( NSURL *)smallImageUrl
               largeImageUrl:( NSURL *)largeImageUrl
                  identifier:(NSString *)identifier
                       title:( NSString *)title{
   self = [super init];
   if( self){
      self.smallImageUrl = smallImageUrl;
      self.largeImageUrl = largeImageUrl;
      self.identifier = identifier;
      self.title = title;
   }
   return self;
}


@end
