//
//  IntegerCounter.h
//  Count5s


#import <Foundation/Foundation.h>

@interface IntegerCounter : NSObject

/* Counts the frequency of number from 0 to n.
 * returns -1 if the input is invalid.
 */
+ (int)frequencyOf:(int)number from0toN:(int)n error:(NSError **)error;

@end
