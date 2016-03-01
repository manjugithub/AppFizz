//
//  BUAcountsTabViewController.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUAcountsTabViewController.h"
#import "BUHomeProfileImgPrevCell.h"
#import "BUConfigurationVC.h"
@interface BUAcountsTabViewController ()
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;

@end

@implementation BUAcountsTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    return self.imgScrollerTableView.frame.size.height;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//{
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    BUHomeProfileImgPrevCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUHomeProfileImgPrevCell"];
//    return cell;
//}

- (IBAction)showProfileDetails:(id)sender {
}

- (IBAction)showPreferences:(id)sender {
}

- (IBAction)showConfiguration:(id)sender
{    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Accounts" bundle:nil];
    BUConfigurationVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUConfigurationVC"];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showInviteFriend:(id)sender {
}

- (IBAction)showHowItWorks:(id)sender {
}

- (IBAction)showHelpAndFeedback:(id)sender {
}
@end
