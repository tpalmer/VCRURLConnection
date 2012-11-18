//
//  VCRURLConnectionExampleTests.m
//  VCRURLConnectionExampleTests
//
//  Created by Dustin Barker on 11/10/12.
//  Copyright (c) 2012 Dustin Barker. All rights reserved.
//

#import "VCRURLConnectionExampleTests.h"
#import "VCRViewController.h"
#import "VCRURLConnection.h"

@interface VCRURLConnectionExampleTests () {
    VCRViewController *_viewController;
}
@end

@implementation VCRURLConnectionExampleTests

- (void)setUp {
    [super setUp];
    [VCRURLConnection setCassetteLibraryPath:@"cassettes"];
    [VCRURLConnection start];
    _viewController = [[VCRViewController alloc] initWithNibName:@"VCRViewController" bundle:[NSBundle mainBundle]];
}

- (void)tearDown {
    [super tearDown];
    [_viewController release]; _viewController = nil;
}

- (void)testExample {
    [VCRURLConnection setCassette:@"example"];

    [_viewController load];
    
    while (!_viewController.isFinishedLoading) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        usleep(10000);
    }
    
    NSString *html = _viewController.HTMLString;
    STAssertFalse(html == nil, @"HTML should not be nil");
    STAssertFalse([html rangeOfString:@"Example Domains"].location == NSNotFound, @"HTML should contain 'Example Domains'");
}

@end
