//
//  ImageListDataSource.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "ImageListDataSource.h"

#import "ImageCell.h"

@interface ImageListDataSource(){
   //contains data to show
   NSArray *imageBeanList;
   UITableView *tableView;
}

@end

@implementation ImageListDataSource

+( float)cellHeight{
   return 50;
}

#define IMAGE_CELL_ID @"IMAGE_CELL_ID"

-( id)initUsingTableView:( UITableView *)__tableView
           imageBeanList:( NSArray *)__imageBeanList{
   self = [super init];
   if(self){
      tableView = __tableView;
      imageBeanList = __imageBeanList;
      //[tableView registerClass:[ImageCell class] forCellReuseIdentifier: IMAGE_CELL_ID];
   }
   return self;
   
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return imageBeanList.count;
}


- (UITableViewCell *)tableView:(UITableView *)__tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   ImageCell *imageCell = ( ImageCell *)[__tableView dequeueReusableCellWithIdentifier: IMAGE_CELL_ID];
   if( imageCell == nil){
      imageCell = [[ImageCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: IMAGE_CELL_ID];
   }
   imageCell.selectionStyle =  UITableViewCellSelectionStyleNone;
   
   ImageBean *imageBean = ( ImageBean *)imageBeanList[ indexPath.row];
   
   //setup cell with current image info
   [imageCell setupUsingImageBean: imageBean];
   return imageCell;
}

#pragma mark -
-( void)reloadUsingImageBeanList:( NSArray *)list{
   imageBeanList = list;
   [tableView reloadData];
}

@end
