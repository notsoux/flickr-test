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
#import "AlertHelper.h"

@interface ImageDetailViewController() < UIScrollViewDelegate>{
   //flag used to detect double tap action -> if last double tap zoomed in it will zoom out and viceversa
   BOOL zoomedInside;
}

@property ( readwrite) UIScrollView *scrollView;
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
   [self.view addSubview: self.scrollView];
   
   [self setupImageView];
   [self.scrollView addSubview: self.imageView];
   
   [self setupConstaintsForScrollViewInsideMainView];
   //[self setupImageViewContraints];
   
   [self downloadImage];


   /*
    double tap inside/out
    */
   UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]
                                               initWithTarget: self
                                               action: @selector(handleDoubleZoom)];
   doubleTapGesture.numberOfTapsRequired = 2;
   [self.scrollView addGestureRecognizer: doubleTapGesture];
}

#pragma mark - zoom
-( void)handleDoubleZoom{
   float zoomScale;
   if( zoomedInside){
      zoomScale = 1.0;
   } else {
      zoomScale = 2.0;
   }
   [self.scrollView setZoomScale: zoomScale animated: YES];
   zoomedInside = !zoomedInside;
}

/*
 setup scrol view for zooming
 */
- (void)setupScrollView {
   self.scrollView = [[UIScrollView alloc] init];
   self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
   //self.scrollView.backgroundColor = [UIColor greenColor];
   
   self.scrollView.delegate = self;
   self.scrollView.minimumZoomScale = 1.0;
   self.scrollView.maximumZoomScale = 3.0;
}

/*
 download hires image
 */
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
                                           [strongSelf setupImageViewContraints];
                                           [strongSelf.view layoutIfNeeded];
                                           [HudHelper hideHudOverView: strongSelf.view];
                                        }
                                     }
                                  } error:^(NSError *error) {
                                     [AlertHelper showAlertWithOnlyOkUsingTitle: @"Error"
                                                                        message: @"Cannot download image"];
                                  }];
}

/*
 setup image view
 */
- (void)setupImageView {
   self.imageView = [[UIImageView alloc] init];
   self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
   self.imageView.contentMode = UIViewContentModeScaleAspectFit;
   //self.imageView.backgroundColor = [UIColor yellowColor];
}

/*
 image view positioning inside scrollView
 */
- (void)setupImageViewContraints{
   
   NSArray *imageViewVerticalPositionconstraints = [NSLayoutConstraint
                                                    constraintsWithVisualFormat: @"V:|-0-[imageView]-0-|"
                                                    options:0
                                                    metrics: nil
                                                    views: [self viewDictionary]];
   NSArray *imageViewHorizontalPositionconstraints = [NSLayoutConstraint
                                                      constraintsWithVisualFormat: @"H:|-0-[imageView]-0-|"
                                                      options:0
                                                      metrics: nil
                                                      views: [self viewDictionary]];
   
   NSDictionary *metrics = @{ @"scrollViewWidth": @(self.scrollView.frame.size.width),
                              @"scrollViewHeight": @(self.scrollView.frame.size.height)};
   
   [self.imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==scrollViewWidth)]"
                                                                          options:0
                                                                          metrics: metrics
                                                                            views: [self viewDictionary]]];
   [self.imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(==scrollViewHeight)]"
                                                                          options:0
                                                                          metrics: metrics
                                                                            views: [self viewDictionary]]];
   
   [self.scrollView addConstraints: imageViewVerticalPositionconstraints];
   [self.scrollView addConstraints: imageViewHorizontalPositionconstraints];
   //[self.view setNeedsLayout];
   //[self.view layoutIfNeeded];
}

- (void)setupConstaintsForScrollViewInsideMainView {
   NSDictionary *viewDictionary;
   viewDictionary = [self viewDictionary];
   
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
   
   
   [self.view addConstraints: scrollVerticalPositionConstraints];
   [self.view addConstraints: scrollHorizontalPositionConstraints];
   
   
}

#pragma mark - util
/*
 dictionary used in constraints
 */
- (NSDictionary *)viewDictionary {
   NSDictionary *viewDictionary = @{ @"scrollView": self.scrollView,
                                     @"imageView": self.imageView};
   return viewDictionary;
}

@end
