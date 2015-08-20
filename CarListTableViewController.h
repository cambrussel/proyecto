//
//  CarListTableViewController.h
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/17/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Cart.h"
#import "CategoryCart.h"

@interface CarListTableViewController : UITableViewController

@property(nonatomic,strong) RLMResults* cart;
@property(nonatomic,strong) CategoryCart *categorySelected;

@end
