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
   
}

@property ( readwrite) UIScrollView *scrollView;
@property ( readwrite) UIView *containerImageView;
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
   
   [self.view addSubview: self.scrollView];
   
   [self downloadImage];
   
   [self setupConstaints];
   
   UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]
                                               initWithTarget: self
                                               action: @selector(handleDoubleZoom)];
   doubleTapGesture.numberOfTapsRequired = 2;
   [self.scrollView addGestureRecognizer: doubleTapGesture];
}

#pragma mark - zoom
-( void)handleDoubleZoom{
   [self.scrollView setZoomScale: 2.0 animated: YES];
}

- (void)setupScrollView {
   self.scrollView = [[UIScrollView alloc] init];
   self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
   self.scrollView.backgroundColor = [UIColor blackColor];
   
   self.scrollView.delegate = self;
   self.scrollView.minimumZoomScale = 1.0;
   self.scrollView.maximumZoomScale = 3.0;
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
                                           [strongSelf setupImageViewContraints];
                                           [strongSelf.view layoutIfNeeded];
                                           [HudHelper hideHudOverView: strongSelf.view];
                                        }
                                     }
                                  } error:^(NSError *error) {
                                     
                                  }];
}


- (void)setupImageView {
   self.containerImageView = [[UIView alloc] initWithFrame: self.scrollView.bounds];
   self.containerImageView.translatesAutoresizingMaskIntoConstraints = NO;
   [self.scrollView addSubview: self.containerImageView];
   //self.scrollView.contentSize = imageContainerView.frame.size;
   self.imageView = [[UIImageView alloc] init];
   //self.imageView.bounds = self.view.bounds;
   self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
   self.imageView.contentMode = UIViewContentModeScaleAspectFit;
   [self.containerImageView addSubview: self.imageView];
}


- (void)setupImageViewContraints{
   //image is centered in scrollView
   NSArray *containerImageViewVerticalPositionconstraints = [NSLayoutConstraint
                                                             constraintsWithVisualFormat: @"V:|-0-[containerImageView]-0-|"
                                                             options:0
                                                             metrics: nil
                                                             views: [self viewDictionary]];
   NSArray *containerImageViewHorizontalPositionconstraints = [NSLayoutConstraint
                                                               constraintsWithVisualFormat: @"H:|-0-[containerImageView]-0-|"
                                                               options:0
                                                               metrics: nil
                                                               views: [self viewDictionary]];
   
   
   NSArray *imageViewVerticalPositionconstraints = [NSLayoutConstraint
                                                    constraintsWithVisualFormat: @"V:|-0-[imageView]-0-|"
                                                    options:0
                                                    metrics: nil
                                                    views: [self viewDictionary]];
   /*NSArray *imageViewHorizontalPositionconstraints = [NSLayoutConstraint
    constraintsWithVisualFormat: @"H:|-0-[imageView]-0-|"
    options:0
    metrics: nil
    views: [self viewDictionary]];*/
   NSLayoutConstraint *centerXConstraint =
   [NSLayoutConstraint constraintWithItem:self.imageView
                                attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.containerImageView
                                attribute:NSLayoutAttributeCenterX
                               multiplier:1.0
                                 constant:0.0];
   NSLayoutConstraint *centerYConstraint =
   [NSLayoutConstraint constraintWithItem:self.imageView
                                attribute:NSLayoutAttributeCenterY
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.containerImageView
                                attribute:NSLayoutAttributeCenterY
                               multiplier:1.0
                                 constant:0.0];
   
   NSDictionary *metrics = @{ @"scrollViewWidth": @(self.scrollView.frame.size.width),
                              @"scrollViewHeight": @(self.scrollView.frame.size.height)};
   [self.containerImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerImageView(==scrollViewWidth)]"
                                                                                   options:0
                                                                                   metrics: metrics
                                                                                     views: [self viewDictionary]]];
   [self.containerImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerImageView(==scrollViewHeight)]"
                                                                                   options:0
                                                                                   metrics: metrics
                                                                                     views: [self viewDictionary]]];
   
   [self.imageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==scrollViewWidth)]"
                                                                          options:0
                                                                          metrics: metrics
                                                                            views: [self viewDictionary]]];
   
   [self.scrollView addConstraints: containerImageViewVerticalPositionconstraints];
   [self.scrollView addConstraints: containerImageViewHorizontalPositionconstraints];
   
   [self.scrollView addConstraints: imageViewVerticalPositionconstraints];
   //[self.scrollView addConstraints: imageViewHorizontalPositionconstraints];
   [self.containerImageView addConstraint: centerXConstraint];
   [self.containerImageView addConstraint: centerYConstraint];
   [self.view setNeedsLayout];
   [self.view layoutIfNeeded];
}

- (NSDictionary *)viewDictionary {
   NSDictionary *viewDictionary = @{ @"scrollView": self.scrollView,
                                     @"imageView": self.imageView,
                                     @"containerImageView":
                                        self.containerImageView};
   return viewDictionary;
}

- (void)setupConstaints {
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


@end
