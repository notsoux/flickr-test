//
//  flickr_testTests.m
//  flickr-testTests
//
//  Created by William Pompei on 26/05/15.
//  Copyright (c) 2015 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FlickrProvider.h"
#import "ImageBean.h"

@interface FlickrProvider( Test)
+ (NSMutableArray *)parsePhotoListFlickrResponse:(NSDictionary *)jsonDict;
@end

/*
 expose private method for testing
*/
@interface flickr_testTests : XCTestCase{
   NSDictionary *testDataDictionary;
}

@end

/*
 json parsing test
 each json is taken from test_data.plist by using a specific test-related key
 */
@implementation flickr_testTests

#pragma mark - util
/*
 utility to setup NSDictionary from test_data.plist
 */
-( NSDictionary *)jsonDictFromTestDataKey:( NSString *) key{
   NSString *jsonString = testDataDictionary[ key];
   NSData *jsonData = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
   NSError *jsonError = nil;
   NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: jsonData
                                                            options: NSJSONReadingMutableContainers
                                                              error: &jsonError];
   return jsonDict;
}

#pragma mark - test
- (void)setUp {
   [super setUp];
   NSBundle *bundle = [NSBundle bundleForClass:[self class]];
   NSString *path = [bundle pathForResource:@"test_data" ofType:@"plist"];
   testDataDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (void)tearDown {
   // Put teardown code here. This method is called after the invocation of each test method in the class.
   [super tearDown];
}

- (void)testEmptyImageListWhenNoImagesAreReturned {
   NSDictionary *jsonDict = [self jsonDictFromTestDataKey: @"empty_photo_list_json"];
   NSArray *imageList = [FlickrProvider parsePhotoListFlickrResponse: jsonDict];
   
   XCTAssert( imageList.count == 0);
}

- (void)testOneImageListWhenOneImagesAreReturned {
   NSDictionary *jsonDict = [self jsonDictFromTestDataKey: @"one_photo_list_json"];
   NSArray *imageList = [FlickrProvider parsePhotoListFlickrResponse: jsonDict];
   XCTAssert( imageList.count == 1);
}


- (void)testThirteenImagesListWhenOneImagesAreReturned {
   NSDictionary *jsonDict = [self jsonDictFromTestDataKey: @"thirteen_photos_list_json"];
   NSArray *imageList = [FlickrProvider parsePhotoListFlickrResponse: jsonDict];
   XCTAssert( imageList.count == 13);
}

- (void)testImageSmallFormatUrl {
   NSDictionary *jsonDict = [self jsonDictFromTestDataKey: @"one_photo_list_json"];
   NSArray *imageList = [FlickrProvider parsePhotoListFlickrResponse: jsonDict];
   ImageBean *imageBean = imageList[ 0];
   NSString *smallImageUrlAsString = imageBean.smallImageUrl.absoluteString;
   XCTAssert( [smallImageUrlAsString isEqualToString:@"https://farm9.staticflickr.com/8843/17357040623_7d02652e18_m.jpg"]);
}

- (void)testImageLargeFormatUrl {
   NSDictionary *jsonDict = [self jsonDictFromTestDataKey: @"one_photo_list_json"];
   NSArray *imageList = [FlickrProvider parsePhotoListFlickrResponse: jsonDict];
   ImageBean *imageBean = imageList[ 0];
   NSString *largeImageUrlAsString = imageBean.largeImageUrl.absoluteString;
   XCTAssert( [largeImageUrlAsString isEqualToString:@"https://farm9.staticflickr.com/8843/17357040623_7d02652e18_b.jpg"]);
}


@end
