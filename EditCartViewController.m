//
//  EditCartViewController.m
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/18/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import "EditCartViewController.h"

@interface EditCartViewController ()

@end

@implementation EditCartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    self.nameTextfield.enabled = NO;
  
}

-(void) initialize{
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editProduct)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    self.nameTextfield.text = self.myCart.name;
    self.priceTextfield.text = [NSString stringWithFormat: @"%d", self.myCart.price];
}

-(void) editProduct{
   
    int price = (int)self.priceTextfield.text;
    //self.selectedProduct.date = [NSDate new];
    
    [self saveInDataBase:price];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) saveInDataBase:(int) newPrice{
    
    RLMRealm *real =[RLMRealm defaultRealm];
    [real beginWriteTransaction];
    self.myCart.price = newPrice;
    [real commitWriteTransaction];
}


@end
