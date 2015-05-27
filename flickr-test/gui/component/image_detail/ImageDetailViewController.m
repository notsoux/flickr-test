//
//  ImageDetailViewController.m
//  flickr-test
//
//  Created by William Pompei on 27/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//
#import "ImageDetailViewController.h"

#import "AsynchImageDownloader.h"
#import "HudHelper.h"

@interface ImageDetailViewController() < UIScrollViewDelegate>{
   
   UIScrollView *scrollView;
   
}

@property ( readwrite) UIImageView *imageView;
@property ( readwrite) ImageBean *imageBean;
@end

@implementation ImageDetailViewController

#pragma mark - init
-( id)initUsingImageBean:( ImageBean *)__imageBean{
   self = [super init];
   if( self){
      self.imageBean = __imageBean;
   }
   return self;
}

#pragma mark - scroll delegate for zoom
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
   return self.imageView;
}

#pragma mark - lifecycle management
-( void)viewDidLoad{
   [super viewDidLoad];
   self.title = self.imageBean.title;
   
   self.edgesForExtendedLayout = UIRectEdgeNone;
   
   [self setupScrollView];
   
   [self setupImageView];
   
   [scrollView addSubview: self.imageView];
   [self.view addSubview: scrollView];
   
   [self downloadImage];
   
   
   [self setupConstaints];
   
   UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]
                                            initWithTarget: self
                                            action: @selector(handleDoubleZoom)];
   doubleTapGesture.numberOfTapsRequired = 2;
   [scrollView addGestureRecognizer: doubleTapGesture];
}

#pragma mark -

-( void)handleDoubleZoom{
   [scrollView setZoomScale: 2.0 animated: YES];
}

- (void)setupScrollView {
   scrollView = [[UIScrollView alloc] init];
   scrollView.translatesAutoresizingMaskIntoConstraints = false;
   scrollView.backgroundColor = [UIColor blackColor];
   
   scrollView.delegate = self;
   scrollView.minimumZoomScale = 1.0;
   scrollView.maximumZoomScale = 3.0;
}

- (void)setupImageView {
   self.imageView = [[UIImageView alloc] init];
   self.imageView.translatesAutoresizingMaskIntoConstraints = false;
   self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)downloadImage {
   [HudHelper showHudOverView: self.view];
   __block __typeof( self) weakSelf = self;
   [AsynchImageDownloader asynchDownload: self.imageBean
                            downloadSize: DOWNLOAD_IMAGE_SIZE_LARGE
                                  finish:^(DownloadedImageBean *downloaded) {
                                     //cell can be reused, so it's necessary to check if, once image has been downlaoded,
                                     //the cell is still the same who asked for it. So:
                                     //if the image downloaded is for me....
                                     __strong __typeof( weakSelf) strongSelf = weakSelf;
                                     if( strongSelf){
                                        if( [downloaded.imageBean.identifier isEqualToString: strongSelf.imageBean.identifier]){
                                           //..show it
                                           strongSelf.imageView.image = downloaded.image;
                                           [HudHelper hideHudOverView: strongSelf.view];
                                        }
                                     }
                                  } error:^(NSError *error) {
                                     
                                  }];
}

- (void)setupConstaints {
   NSDictionary *viewDictionary = @{ @"scrollView": scrollView, @"imageView": self.imageView};
   
   //scrollView occupy all view
   NSArray *scrollVerticalPositionConstraints = [NSLayoutConstraint
                                                 constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|"
                                                 options: 0
                                                 metrics: nil
                                                 views: viewDictionary];
   NSArray *scrollHorizontalPositionConstraints = [NSLayoutConstraint
                                                   constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
                                                   options: 0
                                                   metrics: nil
                                                   views: viewDictionary];
   
   //image is as width as screen
   [self.view addConstraint:[NSLayoutConstraint
                             constraintWithItem:self.imageView
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:scrollView
                             attribute:NSLayoutAttributeWidth
                             multiplier:1.0
                             constant:0.0]];
   
   //image is centered in scrollView
   NSArray *imageViewVerticalPositionconstraints = [NSLayoutConstraint
                                                    constraintsWithVisualFormat: @"V:|-0-[imageView]-0-|"
                                                    options:0
                                                    metrics: nil
                                                    views: viewDictionary];
   NSArray *imageViewHorizontalPositionconstraints = [NSLayoutConstraint
                                                      constraintsWithVisualFormat: @"H:|-0-[imageView]-0-|"
                                                      options:0
                                                      metrics: nil
                                                      views: viewDictionary];
   
   [scrollView addConstraints: imageViewVerticalPositionconstraints];
   [scrollView addConstraints: imageViewHorizontalPositionconstraints];
   
   [self.view addConstraints: scrollVerticalPositionConstraints];
   [self.view addConstraints: scrollHorizontalPositionConstraints];
}


@end
