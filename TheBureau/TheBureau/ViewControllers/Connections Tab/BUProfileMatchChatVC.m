//
//  BUProfileMatchChatVC.m
//  TheBureau
//
//  Created by Accion Labs on 16/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileMatchChatVC.h"
#import "BUContactListTableViewCell.h"
#import "ConversationViewController.h"
#import "BUWebServicesManager.h"

@interface BUProfileMatchChatVC ()
@property(nonatomic) NSArray * imageArray;

@end

@implementation BUProfileMatchChatVC

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
    cell.lastmessageLbl.text = @"Hi How you doing?";
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

{
    return 1;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    
}

-(IBAction)compose:(id)sender{
//    ConversationViewController *controller = [ConversationViewController conversationViewControllerWithLayerClient:[BUWebServicesManager sharedManager].layerClient];
//    controller.displaysAddressBar = YES;
// //   controller.self.proxy_participants = [_selectedaddressParticipants copy];
//  //  controller.productimage = _productImage;
//  //  controller.addressBar_Participants = _selectedaddressParticipants;
//    [self.navigationController pushViewController:controller animated:YES];
    
    
//            UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
//           ConversationViewController  *vc = [sb instantiateViewControllerWithIdentifier:@"ConversationViewController"];
////        vc = [ConversationViewController conversationViewControllerWithLayerClient:[BUWebServicesManager sharedManager].layerClient];
//
//            [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
