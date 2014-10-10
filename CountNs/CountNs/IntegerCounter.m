//
//  IntegerCounter.m
//  Count5s

#import "IntegerCounter.h"

@implementation IntegerCounter


+ (int)frequencyOf:(int)number from0toN:(int)n error:(NSError **)error
{
    if(number > 9 || number <= 0){
        *error = [NSError errorWithDomain:@"com.test.app"
                                     code:100
                                 userInfo:[NSDictionary dictionaryWithObject:@"Incorrect value for number. Should be between 1 and 9" forKey:NSLocalizedDescriptionKey]];
        return -1;
    }
    
    if (n < 0) {
        *error = [NSError errorWithDomain:@"com.test.app"
                                     code:100
                                 userInfo:[NSDictionary dictionaryWithObject:@"Incorrect value for number. Provide a positive integer value" forKey:NSLocalizedDescriptionKey]];
        return -1;
    }
    
    int count = 0;
    
    for (int i = 1; i<=n; i++) {
        count = count + [self countOccurancesOf:number from0toN:i];
    }
    
    return count;
}

/* while number is grater than 0 get the digit in units place.
 * If the units digit is required number, increment the counter.
 * else get the next digit to units place by dividing number by 10.
 */
+ (int)countOccurancesOf:(int)number from0toN:(int)n
{
    int counter = 0;
    
    while (n > 0) {
        
        if (n%10 == number) {
            counter++;
        }
        
        n = n/10;
    }
    
    return counter;
}

@end
