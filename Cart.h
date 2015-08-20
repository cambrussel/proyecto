//
//  Cart.h
//  ProyectoFinal
//
//  Created by Adriana  Cambronero on 8/15/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Cart : RLMObject
    @property NSString* name;
    @property int price;
@end

RLM_ARRAY_TYPE(Cart);