//
//  CategoryCart.h
//  ProyectoFinal
//
//  Created by Adriana  Cambronero on 8/15/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Cart.h"

@interface CategoryCart : RLMObject

@property NSString* name;
@property RLMArray<Cart> *myCart;

@end
