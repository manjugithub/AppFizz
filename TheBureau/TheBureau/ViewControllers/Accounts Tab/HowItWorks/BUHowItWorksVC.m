//
//  BUHowItWorksVC.m
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHowItWorksVC.h"
#import "BUHowItWorksCell.h"

@interface BUHowItWorksVC ()
@property(nonatomic) NSInteger selectedRow;

@end

@implementation BUHowItWorksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedRow = -1;
    // Do any additional setup after loading the view.
    self.title = @"How we work";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BUHowItWorksCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell3"];
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell4"];
            break;
        }
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell5"];
            break;
        }
        default:
            break;
    }
    //Clip whatever is out the cell frame
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat normalHeight = 70;
    CGFloat expandedHeight = 195;

    CGFloat height = 0;
    
    height =  self.selectedRow != indexPath.section ? normalHeight :expandedHeight;
    return height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BUHowItWorksCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.tV setContentOffset:CGPointZero animated:NO];
    
    self.selectedRow = indexPath.section;
    [self.profileTableView beginUpdates];
    [self.profileTableView endUpdates];
    
}

@end
