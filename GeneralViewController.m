//
//  GeneralViewController.m
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/18/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import "GeneralViewController.h"
#import "SHPieChartView.h"
#import "Cart.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


static NSString *CATEGORY1= @"Clothes";
static NSString *CATEGORY2= @"Shoes";
static NSString *CATEGORY3= @"Accesories";
static NSString *CATEGORY4= @"Food";
static NSString *CATEGORY5= @"Electronics";
static NSString *CATEGORY6= @"Other";


@interface GeneralViewController ()

@end

@implementation GeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultCategories];
    //self.categoryArray = [CategoryCart allObjects];
    //[self setAmount];
    [self totalAmountByCategory];
    
}

-(void)loadDefaultCategories{
    RLMResults *categoriesTemp = [CategoryCart allObjects];
    if (categoriesTemp.count>0) {
        //existen categorias
        self.categoryArray = categoriesTemp;
        for (int i = 0; i<self.categoryArray.count ;i++) {
            CategoryCart* object = [self.categoryArray objectAtIndex:i];
            [self totalAmount:object.myCart];
        }
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self setAmount];
}

-(int)totalAmount:(RLMArray<Cart>*)cart{
    for (int i = 0; i<cart.count ;i++) {
        Cart* object = [cart objectAtIndex:i];
        self.totalAmount = self.totalAmount+object.price;
        NSLog(@"Item selected at index %@.", [NSString stringWithFormat: @"$%d", object.price]);
    }

    return self.totalAmount;
}

-(int)totalAmountByCategory{
    int montoTotal =0;
    RLMResults *categoriesTemp = [CategoryCart allObjects];
    if (categoriesTemp.count>0) {
        //existen categorias
        self.categoryArray = categoriesTemp;
        for (int i = 0; i<self.categoryArray.count ;i++) {
            CategoryCart* object = [self.categoryArray objectAtIndex:i];
            
            //[self totalAmount:object.myCart];
            for (int i = 0; i<object.myCart.count ;i++) {
                Cart* object2 = [object.myCart objectAtIndex:i];
                montoTotal = montoTotal+object2.price;
            }
            
            [self.totalCategory addObject: [NSNumber numberWithInt:montoTotal]];
            [self drawChart:self.totalCategory];
        }
    }
    
    
    return montoTotal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAmount{
    self.total.text = [NSString stringWithFormat: @"$%d", [self totalAmount]];
}

-(void)drawChart:(NSMutableArray*)myArray{
    
    
    
    
    SHPieChartView *concentricPieChart = [[SHPieChartView alloc] initWithFrame:CGRectMake(90, 220, 200, 200)];
    concentricPieChart.chartBackgroundColor = UIColorFromRGB(0xFAFAFA);
    
    concentricPieChart.isConcentric = YES;
    concentricPieChart.concentricRadius = 70;
    concentricPieChart.concentricColor = UIColorFromRGB(0x54525C);
    
    
    for (int i = 0; i<myArray.count ;i++) {
        int number = [[myArray objectAtIndex:i]intValue];
        [concentricPieChart addAngleValue:(100*number)/self.totalAmount andClolor:[UIColor redColor]];
        
    }
    
   //[concentricPieChart addAngleValue:0.40 andClolor:[UIColor redColor]];

  
    
    [self.view addSubview:concentricPieChart];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
