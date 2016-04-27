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
#import "BUUtilities.h"
#import "BUDocumentViewVC.h"
@interface BUConfigurationVC ()

@end

@implementation BUConfigurationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Configuration";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [BUUtilities removeLogo:self.navigationController];
    //    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo44"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [BUUtilities setNavBarLogo:self.navigationController image:[UIImage imageNamed:@"logo44"]];
    self.navigationItem.rightBarButtonItem = nil;
    
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

-(IBAction)showTerms:(id)sender
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"BUDocumentViewer" bundle:nil];
    BUDocumentViewVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUDocumentViewVC"];
    vc.documentName = @"TOS.docx";
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showPrivacy:(id)sender
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"BUDocumentViewer" bundle:nil];
    BUDocumentViewVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUDocumentViewVC"];
    vc.documentName = @"PrivacyPolicy.docx";

    [self.navigationController pushViewController:vc animated:YES];
}
@end
