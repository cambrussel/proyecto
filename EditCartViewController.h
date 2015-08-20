//
//  EditCartViewController.h
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/18/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cart.h"

@interface EditCartViewController : UIViewController

@property(nonatomic,strong)Cart *myCart;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *priceTextfield;

@end
