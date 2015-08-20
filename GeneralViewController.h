//
//  GeneralViewController.h
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/18/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "CategoryCart.h"


@interface GeneralViewController : UIViewController

@property(nonatomic,strong) RLMResults *categoryArray;
@property(nonatomic,strong) CategoryCart *categorySelected;
@property(nonatomic)int totalAmount;
@property(nonatomic,strong) NSMutableArray* totalCategory;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end
