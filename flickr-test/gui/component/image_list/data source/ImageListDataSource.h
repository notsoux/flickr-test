//
//  ImageListDataSource.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 image list data source
*/
@interface ImageListDataSource : NSObject < UITableViewDataSource>

/*
 setup using tableView and image list
*/
-( id)initUsingTableView:( UITableView *)__tableView
           imageBeanList:( NSArray *)__imageBeanList;

/*
 update table content using new images
*/
-( void)reloadUsingImageBeanList:( NSArray *)list;

@end
