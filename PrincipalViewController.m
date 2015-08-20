//
//  PrincipalViewController.m
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/16/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import "PrincipalViewController.h"
#import "CategoryCart.h"
#import "Cart.h"
#import "NewCartViewController.h"
#import "GeneralViewController.h"

static int ZERO =0;

@interface PrincipalViewController ()

@end

@implementation PrincipalViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeBackgroundImage];
    [self loadDefaultCategories];
    [self showMenu];
    
    [self initiate];
}

-(void)initiate{
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake(140, 560, 100, 50);
    close.backgroundColor = [UIColor clearColor];
    [close setTitle:@"General" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    close.titleLabel.font = [UIFont fontWithName:@"GillSans-Light" size:18.0f];
    [close addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:close];
}


- (void)hide {
    
    GeneralViewController* newCart =[self.storyboard instantiateViewControllerWithIdentifier:@"generalViewController"];
    [self.navigationController pushViewController:newCart animated:YES];
}


- (void)showMenu {
    NSArray *items = [[NSArray alloc] initWithObjects:@"Clothes", @"Shoes", @"Accesories", @"Food",@"Electronics",@"Other", nil];
    BlurMenu *menu = [[BlurMenu alloc] initWithItems:items parentView:self.view delegate:self];
    [menu show];
}

- (void)changeBackgroundImage {

    NSString *backgroundImage = [NSString stringWithFormat:@"2.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundImage]];
}

#pragma mark - BlurMenu Delegate
- (void)selectedItemAtIndex:(NSInteger)index {
    NSLog(@"Item selected at index %ld.", (long)index);
    [self addToCart:index];
}

- (void)menuDidShow {
    NSLog(@"Menu appeared.");
}

- (void)menuDidHide {
    NSLog(@"Menu disappeared.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark DATABASE OPERATIONS

-(void)insertCategoryInArray{
    CategoryCart *categoria1 = [CategoryCart new];
    categoria1.name = @"Clothes";
    CategoryCart *categoria2 = [CategoryCart new];
    categoria2.name = @"Shoes";
    CategoryCart *categoria3 = [CategoryCart new];
    categoria3.name = @"Accesories";
    CategoryCart *categoria4 = [CategoryCart new];
    categoria4.name = @"Food";
    CategoryCart *categoria5 = [CategoryCart new];
    categoria5.name = @"Electronics";
    CategoryCart *categoria6 = [CategoryCart new];
    categoria6.name = @"Other";
    [self saveInDataBase:categoria1];
    [self saveInDataBase:categoria2];
    [self saveInDataBase:categoria3];
    [self saveInDataBase:categoria4];
    [self saveInDataBase:categoria5];
    [self saveInDataBase:categoria6];
}


-(void)saveInDataBase:(RLMObject*)newObject{
    RLMRealm *real = [RLMRealm defaultRealm];
    [real beginWriteTransaction];
    [real addObject:newObject];
    [real commitWriteTransaction];
}


-(void)loadDefaultCategories{
    RLMResults *categoriesTemp = [CategoryCart allObjects];
    if (categoriesTemp.count>ZERO) {
        //existen categorias
        self.categoryArray = categoriesTemp;
    }
    else{
        //cargar las categorias
        [self insertCategoryInArray];
    }
}


-(void)addToCart:(int)index{
    CategoryCart* selectedObject = [self.categoryArray objectAtIndex:index];
    NewCartViewController* newCart =[self.storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
    newCart.categorySelected = selectedObject;
    [self.navigationController pushViewController:newCart animated:YES];
}







@end
