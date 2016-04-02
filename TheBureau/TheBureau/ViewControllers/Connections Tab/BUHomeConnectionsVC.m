//
//  BUHomeConnectionsVC.m
//  TheBureau
//
//  Created by Accion Labs on 16/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeConnectionsVC.h"
#import "BUHomeConnectionTabVC.h"

@interface BUHomeConnectionsVC ()

@property(nonatomic) BUHomeConnectionTabVC *tabContainerVC;
@property(nonatomic,weak)IBOutlet UIButton *csChatBtn;
@property(nonatomic,weak)IBOutlet UIButton *chatBtn;
@property(nonatomic,weak)IBOutlet UIButton *rematchBtn;


@end

@implementation BUHomeConnectionsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"Connections";
    [_csChatBtn setSelected:YES];
    self.connectionTabItem.badgeValue = [NSString stringWithFormat:@"%ld",[UIApplication sharedApplication].applicationIconBadgeNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showConnectionsSegment:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        
        [_csChatBtn setSelected:YES];
        [_chatBtn setSelected:NO];
        [_rematchBtn setSelected:NO];
    }
    
    else if (sender.tag == 1)
    {
        
        [_csChatBtn setSelected:NO];
        [_chatBtn setSelected:YES];
        [_rematchBtn setSelected:NO];
    }
    else{
        [_csChatBtn setSelected:NO];
        [_chatBtn setSelected:NO];
        [_rematchBtn setSelected:YES];
        
    }
    [self.tabContainerVC showViewControllerFromIndex:sender.tag];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.tabContainerVC = segue.destinationViewController;
    }
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
