//
//  CarListTableViewController.m
//  Proyecto
//
//  Created by Adriana  Cambronero on 8/17/15.
//  Copyright (c) 2015 cenfotec. All rights reserved.
//

#import "CarListTableViewController.h"
#import "EditCartViewController.h"

static int NUMBER_SECTION =1;
static NSString* CELL_IDENTIFIER =@"CELL_CART";
@interface CarListTableViewController ()

@end

@implementation CarListTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    self.title = self.categorySelected.name;


}
                  


-(void)viewWillAppear:(BOOL)animated{
    self.cart = [self.categorySelected.myCart sortedResultsUsingProperty:@"name" ascending:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialize{
    NSMutableArray* barArray =[NSMutableArray new];
    [barArray addObject:self.editButtonItem];
    self.navigationItem.rightBarButtonItems = barArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUMBER_SECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cart count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    if(cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
    }
    
    Cart* object = [self.cart objectAtIndex:indexPath.row];
    cell.textLabel.text = object.name;//falta
   // cell.textLabel.text = [NSString stringWithFormat:@"%d",object.price ];
        return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Cart* selectedObject = [self.cart objectAtIndex:indexPath.row];
    
    EditCartViewController* detailView =[self.storyboard instantiateViewControllerWithIdentifier:@"editCartViewController"];
    detailView.myCart = selectedObject;
    [self.navigationController pushViewController:detailView animated:YES];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
           Cart* object = [self.cart objectAtIndex:indexPath.row];
           [self deleteObjectDataBase:object];
           [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //
        }
}

-(void) deleteObjectDataBase:(Cart*) cart{
    RLMRealm *real =[RLMRealm defaultRealm];
    [real beginWriteTransaction];
    [real deleteObject:cart];
    [real commitWriteTransaction];
}

@end
