//
//  CountNsViewControllerTests.m
//  CountNsViewControllerTests
//

#import <XCTest/XCTest.h>
#import "CountNsViewController.h"

@interface CountNsViewController(private)

@property (nonatomic, weak) UITextField *findOccuranceOfNumber;
@property (nonatomic, weak) UILabel *resultLabel;

@property (nonatomic, weak) UITextField *number;

- (void)clearInput:(UIButton *)sender;
- (BOOL)isInputValid;
- (BOOL)isEmpty;
- (BOOL)isNumber;
- (BOOL)isValidValue;
- (BOOL)isDecimal;
@end

@interface CountNsViewControllerTests : XCTestCase
@property (nonatomic, strong) CountNsViewController *vc;
@end

@implementation CountNsViewControllerTests

- (void)setUp
{
    [super setUp];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"countNs"];
    
    [self.vc view];
}

- (void)tearDown
{
    self.vc = nil;
    [super tearDown];
}

/* Tests if input and result labels are cleared.
 */
- (void)testClearInput
{
    self.vc.findOccuranceOfNumber.text = @"Some text";
    self.vc.number.text = @"some other text";
    self.vc.resultLabel.text = @"result";
    
    [self.vc clearInput:nil];
    
    XCTAssertTrue([@"" isEqualToString:self.vc.findOccuranceOfNumber.text], @"This field should be empty");
    XCTAssertTrue([@"" isEqualToString:self.vc.resultLabel.text], @"This field should be empty");
    XCTAssertTrue([@"" isEqualToString:self.vc.number.text], @"This field should be empty");
}

/* Tests if inputs are provided.
 */
- (void)testIsEmpty
{
    self.vc.findOccuranceOfNumber.text = @"10";
    self.vc.number.text = @"100";
    
    XCTAssertFalse([self.vc isEmpty], @"Should return NO if both the textfields are NOT empty");
    
    self.vc.findOccuranceOfNumber.text = @"";
    self.vc.number.text = @"";
    
    XCTAssertTrue([self.vc isEmpty], @"Should return YES if both textfield's are empty");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a value for Frequency"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"";
    self.vc.number.text = @"10";
    
    XCTAssertTrue([self.vc isEmpty], @"Should return YES if any text field is empty");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a value for Frequency"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"5";
    self.vc.number.text = @"";
    
    XCTAssertTrue([self.vc isEmpty], @"Should return YES if any text field is empty");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a value for N"], @"Result label not set to correctly");

}

/* Tests if inputs provided contains digits.
 */
- (void)testIsNumber
{
    self.vc.findOccuranceOfNumber.text = @"1";
    self.vc.number.text = @"5";
    
    XCTAssertFalse([self.vc isNumber], @"Should return NO if both the textfields contiain valid numbers");
    
    self.vc.findOccuranceOfNumber.text = @"ab";
    self.vc.number.text = @"100";
    
    XCTAssertTrue([self.vc isNumber], @"Should return YES if any text field is contains characters");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Only numeric characters are allowed for Frequency"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"1";
    self.vc.number.text = @"a";
    
    XCTAssertTrue([self.vc isNumber], @"Should return YES if any text field is contains characters");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Only numeric characters are allowed for N"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"ab";
    self.vc.number.text = @"cd";
    
    XCTAssertTrue([self.vc isNumber], @"Should return YES if both textfield's contains characters");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Only numeric characters are allowed for Frequency"], @"Result label not set to correctly");
}

/* Tests if inputs provided contains invalid int values.
 */
- (void)testIsValidValue
{
    self.vc.findOccuranceOfNumber.text = @"1";
    self.vc.number.text = @"5";
    
    XCTAssertFalse([self.vc isValidValue], @"Should return NO if both the textfields are valid integers");
    
    self.vc.findOccuranceOfNumber.text = @"12345678909";
    self.vc.number.text = @"100";
    
    XCTAssertTrue([self.vc isValidValue], @"Should return YES if frequency text field contains a value grater than 9");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a valid integer value between 1 to 9 for Frequency"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"1";
    self.vc.number.text = @"12345678909";
    
    XCTAssertTrue([self.vc isValidValue], @"Should return YES if any text field contains a value grater than MAXINT");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a lesser value for N"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"12345678909";
    self.vc.number.text = @"12345678909";
    
    XCTAssertTrue([self.vc isValidValue], @"Should return YES if any text field is not a valid integer");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a valid integer value between 1 to 9 for Frequency"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"0";
    self.vc.number.text = @"12345678909";
    
    XCTAssertTrue([self.vc isValidValue], @"Should return YES if any text field contains a value grater than MAXINT");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Provide a valid integer value between 1 to 9 for Frequency"], @"Result label not set to correctly");
}

/* Tests if inputs provided contains a decimal number.
 */
- (void)testIsDecimal
{
    self.vc.findOccuranceOfNumber.text = @"1";
    self.vc.number.text = @"5";
    
    XCTAssertFalse([self.vc isDecimal], @"Should return NO if both the textfields are not decimals");
    
    self.vc.findOccuranceOfNumber.text = @"12345.678909";
    self.vc.number.text = @"100";
    
    XCTAssertTrue([self.vc isDecimal], @"Should return YES if any text field is contains decimal number");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Decimal values are not permitted for Frequency"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"1";
    self.vc.number.text = @"123456.9";
    
    XCTAssertTrue([self.vc isDecimal], @"Should return YES if any text field is decimal number");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Decimal values are not permitted for N"], @"Result label not set to correctly");
    
    self.vc.findOccuranceOfNumber.text = @"1.0";
    self.vc.number.text = @"1.9";
    
    XCTAssertTrue([self.vc isDecimal], @"Should return YES if any text field contain decimal number");
    XCTAssertTrue([self.vc.resultLabel.text isEqualToString:@"Decimal values are not permitted for Frequency"], @"Result label not set to correctly");
}


- (void)testIsInputValid
{
    self.vc.findOccuranceOfNumber.text = @"5";
    self.vc.number.text = @"10";
    
    XCTAssertTrue([self.vc isInputValid], @"Should return YES if both text fields contain valid numbers");
    
    
    self.vc.findOccuranceOfNumber.text = @"test";
    self.vc.number.text = @"10";
    XCTAssertFalse([self.vc isInputValid], @"Should return NO if any text field contain a non integer");
   
    self.vc.findOccuranceOfNumber.text = @"11111111111111";
    self.vc.number.text = @"1011111111111";
    XCTAssertFalse([self.vc isInputValid], @"Should returns NO if any text field contains value grater than INT32_MAX");
    
    self.vc.findOccuranceOfNumber.text = @"20.5";
    self.vc.number.text = @"10";
    XCTAssertFalse([self.vc isInputValid], @"Should return NO if any text field contain a decimal");
    
    self.vc.findOccuranceOfNumber.text = @"2";
    self.vc.number.text = @"10.01";
    XCTAssertFalse([self.vc isInputValid], @"Should return NO if any text field contain a decimal");
}

@end
