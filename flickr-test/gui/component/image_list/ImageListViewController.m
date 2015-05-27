//
//  ImageListViewController.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "ImageListViewController.h"
#import "ImageListDataSource.h"
#import "ImageBean.h"

#import "ImageDetailViewController.h"

@interface ImageListViewController() < UITableViewDelegate>{
   NSArray *imageBeanList;
   ImageListDataSource *dataSource;
}

@end

@implementation ImageListViewController


#pragma mark - lifecycle management
-( void)viewDidLoad{
   [super viewDidLoad];
   
   self.title = @"Flickr ParTy";
   
   //setup data source
   dataSource = [[ImageListDataSource alloc] initUsingTableView: self.tableView
                                                                       imageBeanList: imageBeanList];
   self.tableView.dataSource = dataSource;
   
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - update
-( void)reloadDataUsingImageBeanList:( NSArray *)__imageBeanList{
   //update images shown by asking data source
   imageBeanList = __imageBeanList;
   [dataSource reloadUsingImageBeanList: __imageBeanList];
}


#pragma mark - naigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   ImageBean *imageBean = ( ImageBean *)imageBeanList[ indexPath.row];
   ImageDetailViewController *detail = [[ImageDetailViewController alloc] initUsingImageBean: imageBean];
   [self.navigationController pushViewController: detail animated: YES];
}

@end
