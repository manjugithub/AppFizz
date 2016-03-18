//
//  BUConfigurationVC.m
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUConfigurationVC.h"
#import "UIColor+APColor.h"
#import "BUAppNotificationCell.h"

@interface BUConfigurationVC ()

@end

@implementation BUConfigurationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CONFIGURATION";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.cell1 updateBtnStatus];
    [self.cell2 updateBtnStatus];
    [self.cell3 updateBtnStatus];
    [self.cell4 updateBtnStatus];
    [self.cell5 updateBtnStatus];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)startActivityIndicator:(BOOL)isWhite {
    _activityIndicatorCount++;
    if (_activityIndicatorCount > 1) {
        return;
    }
    [[[UIApplication sharedApplication].keyWindow viewWithTag:987] removeFromSuperview];
    [self.activityView removeFromSuperview];
    [self.view layoutIfNeeded];
    //    UIView *activityView = [[UIView alloc] initWithFrame:self.view.bounds];
    if (!self.activityView){
        self.activityView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.activityView.tag = 987;
        self.activityView.backgroundColor = [UIColor clearColor];
        self.activityView.alpha = 0.0f;
        //    [self.view addSubview:activityView];
        
        
        UIView *bgView = [[UIView alloc]initWithFrame:self.activityView.bounds];
        bgView.alpha = 0.0f;
        if ( isWhite ){
            [bgView setBackgroundColor:[UIColor XMApplicationColor]];
        }
        else{
            [bgView setBackgroundColor:[UIColor XMApplicationColor]];
        }
        [self.activityView addSubview:bgView];
        
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityView addSubview:spinner];
        spinner.center = self.activityView.center;
        //    spinner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        if ( isWhite ){
            [spinner setColor:[UIColor redIndicatorColor]];
        }else{
            [spinner setColor:[UIColor whiteColor]];
        }
        [spinner startAnimating];
        
        [UIView animateWithDuration:0.2 animations:^{
            bgView.alpha = 0.5f;
            self.activityView.alpha = 1;
        }];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            self.activityView.alpha = 1;
        }];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityView];
}

- (void)stopActivityIndicator {
    _activityIndicatorCount--;
    if (_activityIndicatorCount <= 0) {
        _activityIndicatorCount = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.activityView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.activityView removeFromSuperview];
        }];
    }
}
@end
