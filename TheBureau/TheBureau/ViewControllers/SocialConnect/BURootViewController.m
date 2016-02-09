//
//  BURootViewController.m
//  TheBureau
//
//  Created by Accion Labs on 17/12/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BURootViewController.h"

@interface BURootViewController ()

@end

@implementation BURootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarLogo];

}
- (void)setNavBarLogo {
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    CGRect myImageS = CGRectMake(0, 0, 44, 44);
    UIImageView *logo = [[UIImageView alloc] initWithFrame:myImageS];
    [logo setImage:[UIImage imageNamed:@"logo44"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.center = CGPointMake(self.navigationController.navigationBar.frame.size.width - logo.frame.size.width, self.navigationController.navigationBar.frame.size.height / 2.0);
    logo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.navigationController.navigationBar addSubview:logo];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;

    
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

@end
