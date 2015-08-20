//
//  NewCartViewController.m
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/16/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import "NewCartViewController.h"
#import <Realm/Realm.h>
#import "CarListTableViewController.h"
#import "PrincipalViewController.h"

@interface NewCartViewController ()

@end

@implementation NewCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    NSLog(@"Item selected at index %@.", self.categorySelected.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialize{
    self.nameTextfield.delegate = self;
    self.priceTextfield.delegate = self;
    self.cart = [Cart new];
    
    UIBarButtonItem *searchButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchCategoryList)];
       NSMutableArray* barArray =[NSMutableArray new];
    [barArray addObject:searchButton];
    self.navigationItem.rightBarButtonItems = barArray;
    
   // self.title = [self.categorySelected stringByAppendingString:NSString stringWithFormat: @"$%d", [self calcularMontoTotal]];
    
}



- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}


// MÉTODO PARA OCULTAR TECLADO CUANDO SE DA RETURN
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.nameTextfield){
        [self animateTextField: textField up: YES];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.priceTextfield){
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 60;
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(int)calcularMontoTotal{
    int h =0;
    
    return h;
}

- (void)searchCategoryList{

    CarListTableViewController* newList =[self.storyboard instantiateViewControllerWithIdentifier:@"cartListTableView"];
    newList.categorySelected = self.categorySelected;
    [self.navigationController pushViewController:newList animated:YES];
}

- (void)returnMenu{
    PrincipalViewController* newMenu =[self.storyboard instantiateViewControllerWithIdentifier:@"principalViewController"];
    [self.navigationController pushViewController:newMenu animated:YES];

}

- (IBAction)createCart:(id)sender {
    
    NSString* titleString = [self.nameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString* descriptionString = [self.priceTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(titleString.length ==0 ||descriptionString ==0){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle: @"Error"message:@"Hay espacios en blanco" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        self.cart.name = self.nameTextfield.text;
        self.cart.price = [self.priceTextfield.text intValue];
        
        RLMRealm *real = [RLMRealm defaultRealm];
        NSLog(@"PATH BD:%@",real.path);
        [real beginWriteTransaction];
        [real addObject:self.cart];
        [self.categorySelected.myCart addObject:self.cart];
        [real commitWriteTransaction];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.cart.name message:[NSString stringWithFormat:@"Item Saved!"] delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
        [alert show];
        
      //  [self.navigationController popViewControllerAnimated:YES];
    }

}
@end
