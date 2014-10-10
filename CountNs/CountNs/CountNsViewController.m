//
//  ViewController.m
//  Count5s
//


#import "CountNsViewController.h"
#import "IntegerCounter.h"

@interface CountNsViewController ()<UITextFieldDelegate>

/* The number for which we need to find the occurances */
@property (nonatomic, weak) IBOutlet UITextField *findOccuranceOfNumber;

/* Display result of operation */
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

@property (nonatomic, weak) IBOutlet UITextField *number;

@end

@implementation CountNsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.findOccuranceOfNumber.delegate = self;
    self.number.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.findOccuranceOfNumber becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)countIntsContainingN:(UIButton *)sender {
    
    __block NSString *result;
    
    if ([self isInputValid]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError* error = nil;
            int counter = [IntegerCounter frequencyOf:[[self.findOccuranceOfNumber text] intValue]
                                             from0toN:[[self.number text] intValue]
                                                error:&error];
            if (!error) {
                result = [NSString stringWithFormat:@"Frequency of %@ from 0 to %@ is %d", [self.findOccuranceOfNumber text], [self.number text],counter];
            }
            else{
                result = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUI:result];
            });
        });

    }
}

- (IBAction)clearInput:(UIButton *)sender {
    self.findOccuranceOfNumber.text = @"";
    self.number.text = @"";
    self.resultLabel.text = @"";
}

/* returns YES if input is valid.
 * returns NO if input is invalid.
 */
- (BOOL)isInputValid
{
    [self.findOccuranceOfNumber resignFirstResponder];
    [self.number resignFirstResponder];
    
    if (![self isEmpty] && ![self isNumber] && ![self isValidValue] && ![self isDecimal]) {
        return YES;
    }

    return NO;
}

/* returns YES if both the inputs are present.
 * returns NO if any or both inputs are empty and updates UI.
 */
- (BOOL)isEmpty
{
    NSString *result;
    
    if ([[self.findOccuranceOfNumber text] length] == 0 || [[self.number text] length] == 0) {
        
        if ([[self.findOccuranceOfNumber text] length] == 0) {
            
            result = @"Provide a value for Frequency";
            
        }
        else{
            
            result = @"Provide a value for N";
            
        }
        
        [self updateUI:result];
        
        return YES;
    }
    
    return NO;
}

/* returns YES if both the inputs are a valid number.
 * returns NO if any or both not numbers and updates UI.
 */
- (BOOL)isNumber
{
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    if (![formatter numberFromString:[self.findOccuranceOfNumber text]] || ![formatter numberFromString:[self.number text]]) {
        
        if (![formatter numberFromString:[self.findOccuranceOfNumber text]]) {
            
            result = @"Only numeric characters are allowed for Frequency";
            
        }
        else{
            
            result = @"Only numeric characters are allowed for N";
            
        }
        
        [self updateUI:result];
        
        return YES;
    }

    return NO;
}

/* returns YES if both the inputs are valid Integers.
 * returns NO if any or both not valid Int and updates UI.
 */
- (BOOL)isValidValue
{
    NSString *result;
    
    if ([[self.findOccuranceOfNumber text] longLongValue] == 0 ||[[self.findOccuranceOfNumber text] longLongValue] > 9 || [[self.number text] longLongValue] > INT32_MAX) {
        
        if ([[self.findOccuranceOfNumber text] longLongValue] > 9 || [[self.findOccuranceOfNumber text] longLongValue] == 0) {
            
            result = @"Provide a valid integer value between 1 to 9 for Frequency";
            
        }
        else{
            
            result = @"Provide a lesser value for N";
            
        }
        
        [self updateUI:result];
        
        return YES;
    }

    return NO;
}

/* returns YES if both the inputs are not decimal.
 * returns NO if any or both decimals and updates UI.
 */
- (BOOL)isDecimal
{
    NSString *result;
    
    if (![self isDecimal:[self.findOccuranceOfNumber text]] || ![self isDecimal:[self.number text]]) {
        
        if (![self isDecimal:[self.findOccuranceOfNumber text]] ) {
            
            result = @"Decimal values are not permitted for Frequency";
            
        }
        else{
            
            result = @"Decimal values are not permitted for N";
            
        }
        
        [self updateUI:result];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isDecimal:(NSString *)input
{
    NSScanner *scanner = [NSScanner scannerWithString:input];
    BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
    return isNumeric;
}

- (void)updateUI:(NSString *)result
{
    self.resultLabel.text = result;
    [self.resultLabel sizeToFit];
}

- (BOOL)textFieldShouldReturn: (UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
}

@end
