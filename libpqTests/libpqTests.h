//
//  libpqTests.h
//  libpqTests
//
//  Created by Kashif Rasul on 04.03.12.
//  Copyright (c) 2012 SpacialDB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "libpq-fe.h"

@interface libpqTests : XCTestCase {
@private
    NSString *conninfo;
    PGconn   *conn;
}
@end
