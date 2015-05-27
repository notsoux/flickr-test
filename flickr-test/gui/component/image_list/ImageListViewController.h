//
//  ImageListViewController.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 image list controller
*/
@interface ImageListViewController : UITableViewController

/*
 update image(s) shown in list
 */
-( void)reloadDataUsingImageBeanList:( NSArray *)imageBeanList;

@end
