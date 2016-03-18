//
//  BUContactListViewController.m
//  TheBureau
//
//  Created by Accion Labs on 26/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUContactListViewController.h"
#import "BUCOntactListTableViewCell.h"
#import "BUWebServicesManager.h"
#import "LQSViewController.h"
#import "BUConstants.h"
#import "BULayerHelper.h"
@interface BUContactListViewController ()

@property(nonatomic) NSArray * imageArray;

@property(nonatomic, weak) IBOutlet UITableView *contactsTableView;

@end


@implementation BUContactListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Chat History";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self getContactsList];
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
         if(nil != inResult && 0 < [inResult count])
         {
             
             [self.contactList removeAllObjects];
             self.contactList = [[NSMutableArray alloc] init];
             for (NSDictionary *dict in inResult)
             {
                 BUChatContact *contact = [[BUChatContact alloc] initWithDict:dict];
                 [self.contactList addObject:contact];
             }
             [self.contactsTableView reloadData];
         }
         else
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
           
             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
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



#pragma TableView DataSource & Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return self.contactList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell" ];//forIndexPath:indexPath];
    [cell setContactListDataSource:[self.contactList objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

{
    return 1;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [[BULayerHelper sharedHelper] setParticipantUserID:[(BUChatContact *)[self.contactList objectAtIndex:indexPath.row] userID]];
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Connections" bundle:nil];
    LQSViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LQSViewController"];
    
    BUChatContact *contact = [self.contactList objectAtIndex:indexPath.row];
    vc.recipientName = [NSString stringWithFormat:@"%@ %@",contact.fName,contact.lName];

    [self.navigationController pushViewController:vc animated:YES];
}



@end
