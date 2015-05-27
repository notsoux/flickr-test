//
//  DownloadedImageBean.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ImageBean.h"

/*
 info to download image
*/
@interface DownloadedImageBean : NSObject

@property ( readonly) ImageBean *imageBean;
@property ( readonly) UIImage *image;

/*
 imageBean : image info
 image : downloaded image
*/
-( id)initUsingImageBean:( ImageBean *)imageBean
                   image:( UIImage *)image;

@end

