//
//  BUBaseViewController.m
//  TheBureau
//
//  Created by Manjunath on 26/11/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "UIColor+APColor.h"

@interface BUBaseViewController ()

@property (nonatomic, strong) UIView *activityView;
@property (atomic, assign) int activityIndicatorCount;


@end

@implementation BUBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.navigationController.navigationBarHidden = YES;
    
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(IBAction)navigateBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) isShowingActivityIndicator
{
    return [self.activityView superview]!=nil;
}

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
        //    CGRect frame = activityView.frame;
        //    if ([self.navigationController.viewControllers containsObject:self]) {
        //        if (!self.navigationController.navigationBarHidden) {
        //            frame.size.height = frame.size.height - 44;
        //        }
        //        frame.size.height -= 44; //logobarview height
        //    }
        //    frame.origin.y -= 50;
        //    frame.size.height +=100;
        //    activityView.frame = frame;
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

- (void)startCustomActivityIndicator:(BOOL)isWhite {
    
    [[[UIApplication sharedApplication].keyWindow viewWithTag:987] removeFromSuperview];
    [self.activityView removeFromSuperview];
    [self.view layoutIfNeeded];
    self.activityView = [[UIView alloc] initWithFrame:self.view.bounds];
    if (self.activityView){
        self.activityView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.activityView.tag = 987;
        //    CGRect frame = activityView.frame;
        //    if ([self.navigationController.viewControllers containsObject:self]) {
        //        if (!self.navigationController.navigationBarHidden) {
        //            frame.size.height = frame.size.height - 44;
        //        }
        //        frame.size.height -= 44; //logobarview height
        //    }
        //    frame.origin.y -= 50;
        //    frame.size.height +=100;
        //    activityView.frame = frame;
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

- (void)stopCustomActivityIndicator {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.activityView.alpha = 0;
        [self.activityView removeFromSuperview];
    } completion:^(BOOL finished) {
        
    }];
}

@end
