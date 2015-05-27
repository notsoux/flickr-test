//
//  ImageDetailViewController.h
//  flickr-test
//
//  Created by William Pompei on 27/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageBean.h"

/*
 Image detail. 
 It's possible to explore image in detail using pan&zoom
 */
@interface ImageDetailViewController : UIViewController

-( id)initUsingImageBean:( ImageBean *)__imageBean;

@end
