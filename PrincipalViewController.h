//
//  PrincipalViewController.h
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/16/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlurMenu.h"
#import <Realm/Realm.h>

@interface PrincipalViewController : UIViewController<BlurMenuDelegate>

@property(nonatomic,strong) RLMResults *categoryArray;

@end
