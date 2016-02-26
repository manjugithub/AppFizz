//
//  BUContactListViewController.m
//  TheBureau
//
//  Created by Accion Labs on 26/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUContactListViewController.h"
#import "BUCOntactListTableViewCell.h"

@interface BUContactListViewController ()

@property(nonatomic) NSArray * imageArray;

@end


@implementation BUContactListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray = [[NSArray alloc]initWithObjects:@"img_photo1",@"img_photo1",@"img_photo1",@"img_photo1", @"img_photo2",@"img_photo2",@"img_photo2",@"img_photo2",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma TableView DataSource & Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return [_imageArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell" ];//forIndexPath:indexPath];
    
    cell.userImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    cell.userName.text = @"vinay";

    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

{
    return 1;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    
}



@end
