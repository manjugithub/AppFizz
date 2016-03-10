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
@property(nonatomic, strong) NSMutableArray *datasourceList;
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) NSMutableArray *contactNamesList;
@property(nonatomic, strong) NSMutableArray *userIDList;


@property(nonatomic, weak) IBOutlet UITableView *contactsTableView;

@end


@implementation BUContactListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Contact List";
    
    _imageArray = [[NSArray alloc]initWithObjects:@"img_photo1",@"img_photo1",@"img_photo1",@"img_photo1", @"img_photo2",@"img_photo2",@"img_photo2",@"img_photo2",nil];
    // Do any additional setup after loading the view.
    
    
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
             self.datasourceList = inResult;
             
             //      self.userProfile = [[BUUserProfile alloc]initWithUserProfile:inResult];
             
             
             self.imagesList = [[NSMutableArray alloc] init];
             self.contactNamesList = [[NSMutableArray alloc] init];
             self.userIDList = [[NSMutableArray alloc] init];


             for (NSDictionary *dict in inResult)
             {
                 if ([[dict valueForKey:@"img_url"] firstObject]) {
                     [self.imagesList addObject:[[dict valueForKey:@"img_url"] firstObject]];
                 }
                 
                 if ([dict valueForKey:@"First Name"]) {
                     [self.contactNamesList addObject:[[dict valueForKey:@"First Name"]firstObject]];
                 }
                 if ([dict valueForKey:@"userid"]) {
                     [self.userIDList addObject:[dict valueForKey:@"userid"]];
                 }
             }
             //
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
    
    return 1;//[_contactNamesList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    BUContactListTableViewCell *cell = (BUContactListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BUContactListTableViewCell" ];//forIndexPath:indexPath];
    
//    cell.userImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    cell.userName.text = @"Vinay";//[self.contactNamesList objectAtIndex:indexPath.row];

    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

{
    return 1;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    [[BULayerHelper sharedHelper] setParticipantUserID:@"12"];
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Connections" bundle:nil];
    LQSViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LQSViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
