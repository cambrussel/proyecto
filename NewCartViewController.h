//
//  NewCartViewController.h
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/16/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCart.h"
#import "Cart.h"

@interface NewCartViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)Cart* cart;
@property(nonatomic,strong)CategoryCart* categorySelected;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *priceTextfield;

- (IBAction)createCart:(id)sender;


@end
