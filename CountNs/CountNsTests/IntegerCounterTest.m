//
//  IntegerCounterTest.m
//  Count5s


#import <XCTest/XCTest.h>
#import "IntegerCounter.h"

@interface IntegerCounterTest : XCTestCase

@end

@implementation IntegerCounterTest

/* Counts the occurance of an integer i from 0 to N.
 */
- (void)testFrequencyOfiFrom0toN
{
    NSError *error;
    
    XCTAssertTrue([IntegerCounter frequencyOf:-1 from0toN:10 error:&error]==-1, @"method should not accept values less than 0");
    XCTAssertTrue([[[error userInfo] objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"Incorrect value for number. Should be between 1 and 9"], @"Error message not set correctly");
    
    XCTAssertTrue([IntegerCounter frequencyOf:10 from0toN:10 error:&error]==-1, @"method should not accept values grater than 9");
    XCTAssertTrue([[[error userInfo] objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"Incorrect value for number. Should be between 1 and 9"], @"Error message not set correctly");
    
    XCTAssertTrue([IntegerCounter frequencyOf:1 from0toN:-1 error:&error]==-1, @"method should not accept values lessthan 0");
    XCTAssertTrue([[[error userInfo] objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"Incorrect value for number. Provide a positive integer value"], @"Error message not set correctly");
    
    XCTAssertTrue([IntegerCounter frequencyOf:1 from0toN:10 error:&error]==2, @"Incorrect number of occurances calculated");
    
    XCTAssertTrue([IntegerCounter frequencyOf:9 from0toN:5 error:&error]==0, @"Incorrect number of occurances calculated");
    
    XCTAssertTrue([IntegerCounter frequencyOf:5 from0toN:5 error:&error]==1, @"Incorrect number of occurances calculated");
}


@end
