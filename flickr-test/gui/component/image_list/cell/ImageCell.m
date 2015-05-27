//
//  ImageCell.m
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import "ImageCell.h"

#import "AsynchImageDownloader.h"

@interface ImageCell(){
   
}

@property ( readwrite) UIImageView *photoImageView;
@property ( readwrite) ImageBean *imageBean;

@end

@implementation ImageCell

#pragma mark - image download
-( void)setupUsingImageBean:( ImageBean *)__imageBean{
   self.imageView.contentMode = UIViewContentModeScaleAspectFit;
   self.imageView.image = [UIImage imageNamed:@"Flickr_Logo"];
   //setup cell layout
   /*if( self.photoImageView == nil){
    self.photoImageView = [[UIImageView alloc] initWithFrame: CGRectMake( 10, 01, 30, 30)];
    [self.contentView addSubview: self.photoImageView];
    }
    */
   //image - cell relationship
   self.imageBean = __imageBean;
   
   self.textLabel.text = self.imageBean.title;
   //asynch download of remote image
   __block __typeof( self) weakSelf = self;
   [AsynchImageDownloader asynchDownload: self.imageBean
                            downloadSize: DOWNLOAD_IMAGE_SIZE_SMALL
                                  finish:^(DownloadedImageBean *downloaded) {
                                     //cell can be reused, so it's necessary to check if, once image has been downlaoded,
                                     //the cell is still the same who asked for it. So:
                                     //if the image downloaded is for me....
                                     __strong __typeof( weakSelf) strongSelf = weakSelf;
                                     if( strongSelf){
                                        if( [downloaded.imageBean.identifier isEqualToString: strongSelf.imageBean.identifier]){
                                           //..show it
                                           strongSelf.imageView.image = downloaded.image;
                                        }
                                     }
                                  } error:^(NSError *error) {
                                     
                                  }];
   
}

#pragma mark - cell lifecycle

-( void)prepareForReuse{
   //clear old image when cell is reused
   
   self.imageBean = nil;
}

@end
