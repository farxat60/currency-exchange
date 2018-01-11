//
//  FirsteViewController.m
//  currencies
//
//  Created by Joe Franc on 12/26/17.
//  Copyright © 2017 Joe Franc. All rights reserved.
//

#import "MainViewController.h"
#import "PickerView.h"
#import "IQKeyboardManager.h"
#import "NBUCurrenciesNetworking.h"


@interface MainViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) PickerView *pickerView;
@property (strong, nonatomic) NBUCurrenciesNetworking *manager;

@property (strong, nonatomic) NSArray *dataModelArray;
@property (strong, nonatomic) NSArray *valueArray;

@property (weak, nonatomic) NSString *nameFirstCurrency;
@property (weak, nonatomic) NSString *nameSecondCurrency;
@property (strong, nonatomic) NSString *textAmount;

- (IBAction)doneButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *currencyFirstLabel;
@property (strong, nonatomic) IBOutlet UILabel *currencySecondLabel;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;

@property (strong, nonatomic) IBOutlet UITextField *enterAmount;

@property (strong, nonatomic) NSDictionary *dictionaryStartFirstCurrencies;
@property (strong, nonatomic) NSDictionary *dictionarySecondCurrencies;



@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView = [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil]objectAtIndex:0];
    self.pickerView.center = self.view.center;
    self.enterAmount.delegate = self;
    [self.enterAmount setKeyboardType:UIKeyboardTypeNumberPad];

    self.manager = [NBUCurrenciesNetworking new];
    
    [self.manager loadCurrency:@"MYR" requestCompletion:^(NSDictionary *responseDict, NSError *error) {
        self.dictionaryStartFirstCurrencies = responseDict;
        self.dataModelArray = [[self.dictionaryStartFirstCurrencies valueForKey:@"rates"]allKeys];
        self.valueArray = [[self.dictionaryStartFirstCurrencies valueForKey:@"rates"] allValues];
    }];
 
}

//PickerView
- (IBAction)doneButton:(id)sender {
    [self.pickerView setHidden:YES];
}
- (IBAction)changeCurrency:(id)sender {
    [self.view addSubview:self.pickerView];
    [self.pickerView setHidden:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return [[self.dictionaryStartFirstCurrencies valueForKey:@"rates"]count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataModelArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.nameFirstCurrency = [self.dataModelArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        self.currencyFirstLabel.text = self.nameFirstCurrency;
    }
    else if (component == 1) {
        self.nameSecondCurrency = [self.dataModelArray objectAtIndex:[pickerView selectedRowInComponent:1]];
        self.currencySecondLabel.text = self.nameSecondCurrency;
    }
    
}
//TextField
- (void) textFieldDidEndEditing:(UITextField *)textField{
    [self.enterAmount resignFirstResponder];
    self.textAmount = textField.text;
}

//Calculate result

- (IBAction)calculateResults:(id)sender {
    [self.manager loadCurrency:self.currencyFirstLabel.text requestCompletion:^(NSDictionary *responseDict, NSError *error) {
        self.dictionarySecondCurrencies = responseDict;
     
        NSString *int2 = [[self.dictionarySecondCurrencies valueForKeyPath:@"rates"] valueForKey:self.currencySecondLabel.text];
        float ints = [self.textAmount floatValue];
        float ints2 = [int2 floatValue];
        NSString *str = [NSString stringWithFormat:@"%.2f", ints *ints2];
        self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@", str, self.nameSecondCurrency];
    }];
}

@end
