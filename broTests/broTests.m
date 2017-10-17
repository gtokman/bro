//
//  broTests.m
//  broTests
//
//  Created by Gary Tokman on 10/16/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRUser.h"

@interface broTests : XCTestCase
@property (nonatomic) BRUser *user;
@end

@implementation broTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.user =[[BRUser alloc] initWithJsonDictionary:@ {
        @"email": @"gtok@gmail.com",
        @"displayName": @"gary",
        @"uid": @"342523452345",
        @"token": @"helloworld",
        @"isBlocked": @(NO),
        @"isFriend": @(NO)
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.user = nil;
}

- (void)testCreatingUser {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertNotNil(self.user);
}

- (void)testUserConvertToJsonReturnsProperUser {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSDictionary *userJson = @ {
        @"email": @"gtok@gmail.com",
        @"displayName": @"gary",
        @"uid": @"342523452345",
        @"token": @"helloworld",
        @"isBlocked": @(NO),
        @"isFriend": @(NO)
    };
    
    XCTAssertEqual([self.user userToJsonDictionary], userJson);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
