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
@property(nonatomic) NSMutableArray * historyList,*contactList;
@property (nonatomic) LYRQueryController *queryController;
@property (nonatomic)LYRClient *layerClient;
@property (nonatomic) IBOutlet UITableView *conversationListTableView;

@end

@implementation BUProfileMatchChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layerClient = [BULayerHelper sharedHelper].layerClient;
    
    self.conversationListTableView.allowsMultipleSelectionDuringEditing = NO;

    
    
    self.title = @"Chat History";

    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated
{
    [self.historyList removeAllObjects];
    [self setupConversationDataSource];
    [self getContactsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupConversationDataSource
{
    
    LYRQuery *query = [LYRQuery queryWithQueryableClass:[LYRConversation class]];
    query.predicate = [LYRPredicate predicateWithProperty:@"participants" predicateOperator:LYRPredicateOperatorIsIn value:self.layerClient.authenticatedUser];
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


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Recent Chats";
    return @"Connections";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return [self.queryController numberOfObjectsInSection:0];
    return self.contactList.count;
}




// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //add code here for when you hit delete
        
        switch (indexPath.section) {
            case 0:
            {
                BUChatContact *contact = [[self historyList] objectAtIndex:indexPath.row];
                LYRConversation *conversation = contact.conversation;
                // Deletes a conversation
                NSError *error = nil;
                [conversation delete:LYRDeletionModeAllParticipants error:&error];
                [[self historyList] removeObjectAtIndex:indexPath.row];
                [self.conversationListTableView reloadData];
            }
                break;
            case 1:
            {
                
                
                BUChatContact *contact = [self.contactList objectAtIndex:indexPath.row];
                
                //                http://app.thebureauapp.com/admin/deleteChatContact
                //
                //                Parameter:
                //                    userid1 => logged in user
                //                    userid2 => user to get deleted
                
                NSDictionary *parameters = nil;
                parameters = @{@"userid1": [BUWebServicesManager sharedManager].userID,
                               @"userid2": contact.userID};
                
                [self startActivityIndicator:YES];
                [[BUWebServicesManager sharedManager] deleteContactWithParameters:parameters successBlock:^(id response, NSError *error)
                 {
                     [self stopActivityIndicator];
                     [self.contactList removeObjectAtIndex:indexPath.row];
                     [self.conversationListTableView reloadData];
                 } failureBlock:^(id response, NSError *error) {
                     [self stopActivityIndicator];
                 }];
                
            }
                break;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            BUChatContact *contact = [[self historyList] objectAtIndex:indexPath.row];
            LYRConversation *conversation = contact.conversation;
            LYRMessage * lastMessage = conversation.lastMessage;
            LYRMessagePart *messagePart = lastMessage.parts[0];
            
            
            NSError *error = nil;
            BOOL success = [conversation delete:LYRDeletionModeAllParticipants error:&error];

            //If it is type image
            
            BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell" ];//forIndexPath:indexPath];
            [cell setContactListDataSource:contact];
            
            if ([messagePart.MIMEType isEqualToString:@"image/png"]) {
                cell.lastmessageLbl.text = @""; //
                
            } else {
                cell.lastmessageLbl.text =[[NSString alloc]initWithData:messagePart.data
                                                               encoding:NSUTF8StringEncoding];
            }
            
            NSString *timestampText = @"";
            
            
            // If the message was sent by current user, show Receipent Status Indicator
            if ([lastMessage.sender.userID isEqualToString:[[BULayerHelper sharedHelper] currentUserID]]) {
                
                NSDate *date = lastMessage.sentAt;
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                df.dateStyle = kCFDateFormatterShortStyle;
                df.doesRelativeDateFormatting = YES;
                timestampText = [df stringFromDate:date];
            } else
            {
                
                NSDate *date = lastMessage.receivedAt;
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                df.dateStyle = kCFDateFormatterShortStyle;
                df.doesRelativeDateFormatting = YES;
                timestampText = [df stringFromDate:date];
            }
            
            
            cell.timeLbl.text = [NSString stringWithFormat:@"%@",timestampText];
            
            if (conversation.hasUnreadMessages) {
                cell.unreadMessageIndicator.hidden = NO;
            } else {
                cell.unreadMessageIndicator.hidden = YES;
            }
            return cell;

        }break;
           
        case 1:
        {
            BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell1" ];//forIndexPath:indexPath];
            [cell setContactListDataSource:[self.contactList objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
        case 0:
        {
            LYRConversation *conversation = [self.queryController objectAtIndexPath:indexPath];
            for (NSString *participant in conversation.participants) {
                if (![participant isEqualToString:self.layerClient.authenticatedUser.userID] ) {
                    [[BULayerHelper sharedHelper] setParticipantUserID:participant];
                    
                }
            }
            
            BUChatContact *contact = [[self historyList] objectAtIndex:indexPath.row];
            
            UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Connections" bundle:nil];
            LQSViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LQSViewController"];
            vc.conversation = conversation;
            vc.recipientName = [NSString stringWithFormat:@"%@ %@",contact.fName,contact.lName];
            vc.recipientID = contact.userID;
            vc.recipientDPURL = contact.imgURL;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
        case 1:
        {
            [[BULayerHelper sharedHelper] setParticipantUserID:[(BUChatContact *)[self.contactList objectAtIndex:indexPath.row] userID]];
            UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Connections" bundle:nil];
            LQSViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LQSViewController"];
            
            BUChatContact *contact = [self.contactList objectAtIndex:indexPath.row];
            vc.recipientName = [NSString stringWithFormat:@"%@ %@",contact.fName,contact.lName];
            vc.recipientID = contact.userID;
            vc.recipientDPURL = contact.imgURL;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
    
    
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
    if([[self historyList] count] > 1)
        [self.conversationListTableView endUpdates];
}


#pragma TableView DataSource & Delegates

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
    
    NSInteger row = 0;
    NSInteger count = [self.queryController numberOfObjectsInSection:row];
    NSMutableArray *useridsArray = [[NSMutableArray alloc] init];
    [self.historyList removeAllObjects];
    self.historyList = [[NSMutableArray alloc] init];
    
    for (row =0 ; row < count; row++)
    {
        LYRConversation *conversation = [self.queryController objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        for (NSString *participant in conversation.participants) {
            if (![participant isEqualToString:self.layerClient.authenticatedUser.userID] )
            {
                
                if(1)// ([participant rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location == NSNotFound)
                {
                    BUChatContact *contact = [[BUChatContact alloc] init];
                    contact.userID = participant;
                    contact.conversation = conversation;
                    [self.historyList addObject:contact];
                    [useridsArray addObject:participant];
                }
            }
            
        }
    }
    
    NSDictionary *parameters = nil;
    parameters = @{@"userids": useridsArray
                   };

//    NSArray *params = @[@"12",@"7",@"152",@"16"];
    NSString *baseURL = @"http://dev.thebureauapp.com/admin/getUserDetails";
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] queryServer:parameters
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
             for (NSDictionary *userData in inResult)
             {
                 for (BUChatContact *contact in self.historyList)
                 {
                     if([contact.userID isEqualToString:[userData valueForKey:@"userid"]])
                     {
                         contact.fName = [userData valueForKey:@"First Name"];
                         contact.lName = [userData valueForKey:@"Last Name"];
                         contact.imgURL = [userData valueForKey:@"img_url"];
                         
                         NSLog(@"Name ==> %@ \n user id ==> %@",contact.fName,contact.userID);
                     }
                 }
             }
             [self.conversationListTableView reloadData];
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



-(void)getContactsList
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] getContactListwithParameters:parameters
                                                          successBlock:^(id inResult, NSError *error)
     {
         [self stopActivityIndicator];
         if(nil != inResult)
         {
             
             [self.contactList removeAllObjects];
             self.contactList = [[NSMutableArray alloc] init];
             for (NSDictionary *dict in inResult)
             {
                 BUChatContact *contact = [[BUChatContact alloc] initWithDict:dict];
                 [self.contactList addObject:contact];
             }
             [self.conversationListTableView reloadData];
         }
         else
         {
             
         }
     }
                                                          failureBlock:^(id response, NSError *error)
     {
         
     }];
}

@end
