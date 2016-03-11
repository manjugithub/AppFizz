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
    [self.conversationListTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.queryController numberOfObjectsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYRConversation *conversation = [self.queryController objectAtIndexPath:indexPath];
    BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell" ];//forIndexPath:indexPath];
    for (NSString *participant in conversation.participants) {
        if (![participant isEqualToString:self.layerClient.authenticatedUserID] ) {
            cell.userName.text = participant;
            
        }
    }
    
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

@end
