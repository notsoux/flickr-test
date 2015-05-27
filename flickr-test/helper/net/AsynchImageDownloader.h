//
//  AsynchImageDownloader.h
//  flickr-test
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageBean.h"
#import "DownloadedImageBean.h"

typedef enum
{
   DOWNLOAD_IMAGE_SIZE_SMALL,
   DOWNLOAD_IMAGE_SIZE_LARGE
} DOWNLOAD_IMAGE_SIZE_ENUM;


/*
 asynch image downalod
 */
@interface AsynchImageDownloader : UITableViewCell

/*
 asynch image download.
 imageBean : info used to downalod image
 finishBlock : image downloaded
 errorBlock : error downloading image
 */
+( void)asynchDownload:( ImageBean *)imageBean
          downloadSize:( DOWNLOAD_IMAGE_SIZE_ENUM)downloadSize
                finish:( void (^) ( DownloadedImageBean *))finishBlock
                 error:( void( ^)( NSError *)) errorBlock;

@end
