//
//  libpqTests.m
//  libpqTests
//
//  Created by Kashif Rasul on 04.03.12.
//  Copyright (c) 2012 SpacialDB. All rights reserved.
//

#import "libpqTests.h"

@implementation libpqTests

- (void)setUp
{
    [super setUp];
    
    NSLog(@"%@ start", self.name);
    conninfo = [NSString stringWithFormat:@"dbname='%@'", @"postgres"];
    conn = PQconnectdb([conninfo UTF8String]);
}

- (void)tearDown
{
    NSLog(@"%@ stop", self.name);
    PQfinish(conn);
    
    [super tearDown];
}

- (void)testConnectionOK
{
    NSLog(@"%@ start", self.name);
    if (PQstatus(conn) != CONNECTION_OK) {
        NSString *message = [[NSString alloc] initWithUTF8String:PQerrorMessage(conn)];
        NSLog(@"Connection to database failed: %@", message);
    }
}

- (void)testTransaction
{
    NSLog(@"%@ start", self.name);
    
    PGresult   *res;
    res = PQexec(conn, "BEGIN");
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        NSString *message = [[NSString alloc] initWithUTF8String:PQerrorMessage(conn)];
        NSLog(@"BEGIN command failed: %@", message);
    }
    PQclear(res);
    
    res = PQexec(conn, "END");
    PQclear(res);
}

- (void)testFetch
{
    NSLog(@"%@ start", self.name);
    
    PGresult   *res;
    res = PQexec(conn, "BEGIN");
    PQclear(res);
    
    res = PQexec(conn, "DECLARE myportal CURSOR FOR select * from pg_database");
    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        NSString *message = [[NSString alloc] initWithUTF8String:PQerrorMessage(conn)];
        NSLog(@"DECLARE CURSOR failed: %@", message);
    }
    PQclear(res);
    
    res = PQexec(conn, "FETCH ALL in myportal");
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        NSString *message = [[NSString alloc] initWithUTF8String:PQerrorMessage(conn)];
        NSLog(@"FETCH ALL failed: %@", message);
    }
    
    int nFields = PQnfields(res);
    for (int i = 0; i < nFields; i++)
    {
        NSString *name = [[NSString alloc] initWithUTF8String:PQfname(res, i)];
        NSLog(@"%@\n\n", name);
    }
    
    for (int i = 0; i < PQntuples(res); i++)
    {
        for (int j = 0; j < nFields; j++) {
            NSString *value = [[NSString alloc] initWithUTF8String:PQgetvalue(res, i, j)];
            NSLog(@"%@\n", value);
        }
    }
    PQclear(res);
    
    res = PQexec(conn, "CLOSE myportal");
    PQclear(res);
    
    res = PQexec(conn, "END");
    PQclear(res);
}
@end
