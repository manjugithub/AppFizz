//
//  BUCustomerServiceChatVC.m
//  TheBureau
//
//  Created by Accion Labs on 16/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUCustomerServiceChatVC.h"
#import <Smooch/Smooch.h>

@interface BUCustomerServiceChatVC ()

@end

@implementation BUCustomerServiceChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    // Do any additional setup after loading the view.

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)chatWithCustomerService:(id)sender{
    
    [Smooch showConversationFromViewController:self];

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
