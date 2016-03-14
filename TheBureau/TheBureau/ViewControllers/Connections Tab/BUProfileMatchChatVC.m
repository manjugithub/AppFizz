//
//  BUProfileMatchChatVC.m
//  TheBureau
//
//  Created by Accion Labs on 16/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileMatchChatVC.h"
#import "BUContactListTableViewCell.h"
#import "BUWebServicesManager.h"
#import "BULayerHelper.h"
#import "LQSViewController.h"

static NSDateFormatter *LQSDateFormatter()
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MMM";
    }
    return dateFormatter;
}
@interface BUProfileMatchChatVC ()<LYRQueryControllerDelegate>
@property(nonatomic) NSArray * imageArray;
@property (nonatomic) LYRQueryController *queryController;
@property (nonatomic)LYRClient *layerClient;
@property (nonatomic) IBOutlet UITableView *conversationListTableView;

@end

@implementation BUProfileMatchChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layerClient = [BULayerHelper sharedHelper].layerClient;
    _imageArray = [[NSArray alloc]initWithObjects:@"img_photo1",@"img_photo1",@"img_photo1",@"img_photo1", @"img_photo2",@"img_photo2",@"img_photo2",@"img_photo2",nil];
    
    [self setupConversationDataSource];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupConversationDataSource
{
    
    
    
    LYRQuery *query = [LYRQuery queryWithQueryableClass:[LYRConversation class]];
    query.predicate = [LYRPredicate predicateWithProperty:@"participants" predicateOperator:LYRPredicateOperatorIsIn value:self.layerClient.authenticatedUserID];
    query.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastMessage.receivedAt" ascending:NO]];
    
    
    NSError *error;
    self.queryController = [self.layerClient queryControllerWithQuery:query error:&error];
    if (!self.queryController) {
        NSLog(@"LayerKit failed to create a query controller with error: %@", error);
        return;
    }
    self.queryController.delegate = self;
    BOOL success = [self.queryController execute:&error];
    if (!success) {
        NSLog(@"LayerKit failed to execute query with error: %@", error);
        return;
    }
    [self getContactDetails];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.queryController numberOfObjectsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRConversation *conversation = [self.queryController objectAtIndexPath:indexPath];
    LYRMessage * lastMessage = conversation.lastMessage;
    LYRMessagePart *messagePart = lastMessage.parts[0];
    
    //If it is type image
   
    BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell" ];//forIndexPath:indexPath];
    for (NSString *participant in conversation.participants) {
        if (![participant isEqualToString:self.layerClient.authenticatedUserID] ) {
            cell.userName.text = @"vinay";
            cell.userImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
            
        }
    }
    
    if ([messagePart.MIMEType isEqualToString:@"image/png"]) {
        cell.lastmessageLbl.text = @""; //
        
    } else {
        cell.lastmessageLbl.text =[[NSString alloc]initWithData:messagePart.data
                                              encoding:NSUTF8StringEncoding];
    }
    
    NSString *timestampText = @"";
    
    
    // If the message was sent by current user, show Receipent Status Indicator
    if ([lastMessage.sender.userID isEqualToString:[[BULayerHelper sharedHelper] currentUserID]]) {
        
      timestampText = [NSString stringWithFormat:@"%@",[LQSDateFormatter() stringFromDate:lastMessage.sentAt]];
    } else {
        timestampText = [NSString stringWithFormat:@"%@",[LQSDateFormatter() stringFromDate:lastMessage.receivedAt]];
    }
        cell.timeLbl.text = [NSString stringWithFormat:@"%@",timestampText];
 


    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRConversation *conversation = [self.queryController objectAtIndexPath:indexPath];
    for (NSString *participant in conversation.participants) {
        if (![participant isEqualToString:self.layerClient.authenticatedUserID] ) {
            [[BULayerHelper sharedHelper] setParticipantUserID:participant];
            
        }
    }
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Connections" bundle:nil];
    LQSViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LQSViewController"];
    vc.conversation = conversation;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)queryControllerWillChangeContent:(LYRQueryController *)queryController
{
    [self.conversationListTableView beginUpdates];
}

- (void)queryController:(LYRQueryController *)controller
        didChangeObject:(id)object
            atIndexPath:(NSIndexPath *)indexPath
          forChangeType:(LYRQueryControllerChangeType)type
           newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case LYRQueryControllerChangeTypeInsert:
            [self.conversationListTableView insertRowsAtIndexPaths:@[newIndexPath]
                                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeUpdate:
            [self.conversationListTableView reloadRowsAtIndexPaths:@[indexPath]
                                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeMove:
            [self.conversationListTableView deleteRowsAtIndexPaths:@[indexPath]
                                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.conversationListTableView insertRowsAtIndexPaths:@[newIndexPath]
                                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case LYRQueryControllerChangeTypeDelete:
            [self.conversationListTableView deleteRowsAtIndexPaths:@[indexPath]
                                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)queryControllerDidChangeContent:(LYRQueryController *)queryController
{
    [self.conversationListTableView endUpdates];
}


#pragma TableView DataSource & Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

{
    return 1;
    
    
}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//
//
//
//}

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



-(void)getContactDetails

{
    
    NSArray *params = @[@"8",@"12"];
    NSString *baseURL = @"http://app.thebureauapp.com/admin/getUserDetails";
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] queryServerWithList:params
                                              baseURL:baseURL
                                         successBlock:^(id inResult, NSError *error)
     {
         [self stopActivityIndicator];
         if([inResult isKindOfClass:[NSDictionary class]])
         {
             if([[inResult valueForKey:@"msg"] isEqualToString:@"Error"])
             {
                 [self stopActivityIndicator];
                 NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[inResult valueForKey:@"response"]];
                 [message addAttribute:NSFontAttributeName
                                 value:[UIFont fontWithName:@"comfortaa" size:15]
                                 range:NSMakeRange(0, message.length)];
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                 [alertController setValue:message forKey:@"attributedTitle"];
                 [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                 [self presentViewController:alertController animated:YES completion:nil];
                 
                 return ;
             }
         }
         if(nil != inResult && 0 < [inResult count])
         {
             //Liked Passed
             [self.conversationListTableView reloadData];
         }
         else
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];              [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
         }
     }
                                                   failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }];
    

}


@end
