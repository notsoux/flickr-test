//
//  PhotoProvider.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 specific provider used in app ( at the moment the flickr one)
*/
@interface PhotoProvider : UIViewController

+( void)photoListWithTag:( NSString *)tag
                  finish:( void (^) ( NSArray *))finishBlock
                   error:( void( ^)( NSError *)) errorBlock;

@end
