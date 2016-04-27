//
//  BUPoolProfileDetailsVC.m
//  TheBureau
//
//  Created by Manjunath on 22/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUPoolProfileDetailsVC.h"
#import "BUHomeImagePreviewCell.h"
#import "BUMatchInfoCell.h"
@interface BUPoolProfileDetailsVC ()
@property(nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;
@property(nonatomic, strong) NSMutableArray *keysList;

@property(nonatomic, strong) IBOutlet UIButton *anonymousBtn,*anonymousPayBtn,*directBtn,*directPayBtn;


-(IBAction)anonymousClicked:(id)sender;
-(IBAction)payAnonymousClicked:(id)sender;
-(IBAction)directClicked:(id)sender;
-(IBAction)payDirectClicked:(id)sender;

@end

@implementation BUPoolProfileDetailsVC
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"TheBureau";
    self.navigationItem.hidesBackButton = NO;
    
    [self cookupDataSource];
}

-(void)cookupDataSource
{
    self.imagesList = [[NSMutableArray alloc] initWithArray:[self.datasourceList valueForKey:@"img_url"]];
    
    NSDictionary *respDict = self.datasourceList;

    self.keysList = [[NSMutableArray alloc] init];

//    NSString *profileName = [NSString stringWithFormat:@"%@ %@",[respDict valueForKey:@"profile_first_name"],[respDict valueForKey:@"profile_last_name"]];
    
    [self.datasourceList setValue:[respDict valueForKey:@"created_by"] forKey:@"Profile created by"];
    [self.keysList addObject:@"Profile created by"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"dob"] forKey:@"DOB"];
    [self.keysList addObject:@"DOB"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"location"] forKey:@"Location"];
    [self.keysList addObject:@"Location"];
    
    
    NSString *height = [NSString stringWithFormat:@"%@' %@\"",[respDict valueForKey:@"height_feet"],[respDict valueForKey:@"height_inch"]];
    [self.datasourceList setValue:height forKey:@"Height"];
    [self.keysList addObject:@"Height"];
    
        
//    [self.datasourceList setValue:[respDict valueForKey:@"mother_tongue"] forKey:@"Mother Toungue"];
//    [self.keysList addObject:@"Mother Toungue"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"religion_name"] forKey:@"Religion"];
    [self.keysList addObject:@"Religion"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"family_origin_name"] forKey:@"Family Origin"];
    [self.keysList addObject:@"Family Origin"];
    
//    [self.datasourceList setValue:@"" forKey:@"Specification"];
//    [self.keysList addObject:@"Specification"];

    [self.datasourceList setValue:[respDict valueForKey:@"highest_education"] forKey:@"Education"];
    [self.keysList addObject:@"Education"];
    
//    [self.datasourceList setValue:[respDict valueForKey:@"honors"] forKey:@"Honors"];
//    [self.keysList addObject:@"Honors"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"major"] forKey:@"Major"];
//    [self.keysList addObject:@"Major"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"college"] forKey:@"College"];
//    [self.keysList addObject:@"College"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"graduated_year"] forKey:@"Year"];
//    [self.keysList addObject:@"Year"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"employment_status"] forKey:@"Occupation"];
    [self.keysList addObject:@"Occupation"];
    
//    [self.datasourceList setValue:[respDict valueForKey:@"company"] forKey:@"Employer"];
//    [self.keysList addObject:@"Employer"];
//
//    [self.datasourceList setValue:[respDict valueForKey:@"diet"] forKey:@"Diet"];
//    [self.keysList addObject:@"Diet"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"smoking"] forKey:@"Smoking"];
//    [self.keysList addObject:@"Smoking"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"drinking"] forKey:@"Drinking"];
//    [self.keysList addObject:@"Drinking"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"years_in_usa"] forKey:@"Years in USA"];
//    [self.keysList addObject:@"Years in USA"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"legal_status"] forKey:@"Legal Status"];
//    [self.keysList addObject:@"Legal Status"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"profile_dob"] forKey:@"Date of Birth"];
//    [self.keysList addObject:@"Date of Birth"];
//    
//    [self.datasourceList setValue:@"" forKey:@"Time of Birth"];
//    [self.keysList addObject:@"Time of Birth"];
//    
//    [self.datasourceList setValue:[respDict valueForKey:@"about_me"] forKey:@"About Me"];
//    [self.keysList addObject:@"About Me"];
//
    [self.collectionView reloadData];
    [self.imgScrollerTableView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 100);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.pageControl.numberOfPages = self.imagesList.count;
    return self.imagesList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUHomeImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUHomeImagePreviewCell"
                                                                             forIndexPath:indexPath];
    [cell setImageURL:[self.imagesList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.row;
    NSLog(@"collectionView willDisplayCell: %ld",indexPath.row);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 20;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.keysList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BUMatchInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUMatchInfoCell"];
    NSString *key = [self.keysList objectAtIndex:indexPath.row];
    
    if([key isEqualToString:@"Honors"] || [key isEqualToString:@"Major"] || [key isEqualToString:@"College"] || [key isEqualToString:@"Year"])
    {
        cell.matchTitleLabel.text = [NSString stringWithFormat:@"            %@",key];
    }
    else
    {
        cell.matchTitleLabel.text = [NSString stringWithFormat:@"    %@",key];
    }
    cell.matchDescritionLabel.text = [NSString stringWithFormat:@"    %@",[self.datasourceList valueForKey:key]];
    return cell;
}


-(IBAction)anonymousClicked:(id)sender
{
    self.anonymousBtn.hidden = YES;
    self.anonymousPayBtn.hidden = NO;
    self.directBtn.hidden = NO;
    self.directPayBtn.hidden = YES;
}

-(IBAction)payAnonymousClicked:(id)sende
{
    
//    http://app.thebureauapp.com/admin/accessUserProfile
    
    
    
//http://app.thebureauapp.com/admin/accessUserProfile
    
    
//    Parameters :
//    
//    userid => User id of the user who is visiting/accessing the other users profile
//    
//    visited_userid => User id of the user whose profile is being visited/accessed by the above user
//    
//    access_type => Takes only two values => Anonymous / Direct
//    
//    gold_amount => Amount of gold to be deducted from the users account for visiting the other users profile

    
    [self startActivityIndicator:YES];
    NSString *baseURl = @"http://app.thebureauapp.com/admin/accessUserProfile";
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"visited_userid": [self.datasourceList valueForKey:@"userid"],
                   @"access_type": @"Anonymous",
                   @"gold_amount": @"500"
                   };
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         if([response valueForKey:@"msg"] != nil && [[response valueForKey:@"msg"] isEqualToString:@"Error"])
         {
             [self stopActivityIndicator];
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[response valueForKey:@"response"]];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
             return;
         }
         else
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"You have sent interest anonymously!"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
             
             [alertController addAction:({
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     self.anonymousBtn.enabled = NO;
                     self.anonymousPayBtn.enabled = NO;
                     self.directBtn.enabled = NO;
                     self.directPayBtn.enabled = NO;
                 }];
                 
                 action;
             })];
             
             [self presentViewController:alertController  animated:YES completion:nil];
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
         [alertController setValue:message forKey:@"attributedTitle"];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }
     ];

    
    
}


-(IBAction)directClicked:(id)sender
{
    self.directBtn.hidden = YES;
    self.directPayBtn.hidden = NO;
    self.anonymousBtn.hidden = NO;
    self.anonymousPayBtn.hidden = YES;
}

-(IBAction)payDirectClicked:(id)sender
{
    
    [self startActivityIndicator:YES];
    NSString *baseURl = @"http://app.thebureauapp.com/admin/accessUserProfile";
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"visited_userid": [self.datasourceList valueForKey:@"userid"],
                   @"access_type": @"Direct",
                   @"gold_amount": @"500"
                   };
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         if([response valueForKey:@"msg"] != nil && [[response valueForKey:@"msg"] isEqualToString:@"Error"])
         {
             [self stopActivityIndicator];
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[response valueForKey:@"response"]];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
             return;
         }
         else
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"You have sent an interest!"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
             
             [alertController addAction:({
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     self.anonymousBtn.enabled = NO;
                     self.anonymousPayBtn.enabled = NO;
                     self.directBtn.enabled = NO;
                     self.directPayBtn.enabled = NO;
                 }];
                 
                 action;
             })];
             
             [self presentViewController:alertController  animated:YES completion:nil];
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
         [alertController setValue:message forKey:@"attributedTitle"];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }
     ];
    
    

}


@end