//
//  ImageCell.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageBean.h"


/*
 cell showing single image in image list
*/
@interface ImageCell : UITableViewCell

/*
 update cell using currently associated image data
*/
-( void)setupUsingImageBean:( ImageBean *)__imageBean;

@end
