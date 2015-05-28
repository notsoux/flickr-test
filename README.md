# flickr-test
Test iOS app connecting to flickr to download photo with tag 'party'

# Installation
The project uses CocoaPods: after cloning, launch **pod install** and reopen project using **flickr-test.xcworkspace**

To show photo from flickr, an api key is needed: you can create one here -> https://www.flickr.com/services/apps/create/

In file **flickr_test/configuration.plist** insert your flickr api key

# Test
There are some tests related to flickr json response parsing.
Json data are located in **flickr-testTests/test_data.plist**
