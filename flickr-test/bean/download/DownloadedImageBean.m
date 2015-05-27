//
//  DownloadedImageBean.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "DownloadedImageBean.h"

@interface DownloadedImageBean(){
   
}


@property ( readwrite) ImageBean *imageBean;
@property ( readwrite) UIImage *image;

@end


@implementation DownloadedImageBean

-( id)initUsingImageBean:( ImageBean *)imageBean
                   image:( UIImage *)image{
   self = [super init];
   if( self){
      self.imageBean = imageBean;
      self.image = image;
   }
   return self;
}

@end
