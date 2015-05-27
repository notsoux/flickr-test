//
//  ImageBean.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 image info
*/
@interface ImageBean : NSObject

//small image url (preview image)
@property ( strong, readonly) NSURL *smallImageUrl;

//detailed image url
@property ( strong, readonly) NSURL *largeImageUrl;

//image unique identifier used to show image correctly
//when using asynch download
@property ( strong, readonly) NSString *identifier;

//image title
@property ( strong, readonly) NSString *title;

-( id)initUsingSmallImageURL:( NSURL *)smallImageUrl
               largeImageUrl:( NSURL *)largeImageUrl
                  identifier:(NSString *)identifier
                       title:( NSString *)title;

@end
