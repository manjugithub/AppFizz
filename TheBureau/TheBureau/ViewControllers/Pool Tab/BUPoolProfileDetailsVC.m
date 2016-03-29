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
@property(nonatomic, strong) NSDictionary *datasourceDict;
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;

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
    self.navigationItem.title = @"The Bureau";
    self.navigationItem.hidesBackButton = NO;
    
    [self cookupDataSource];
}

-(void)cookupDataSource
{
    self.imagesList = [[NSMutableArray alloc] initWithArray:[self.datasourceList valueForKey:@"img_url"]];
    
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
    return 40;    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.datasourceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
        BUMatchInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUMatchInfoCell"];
        NSString *key = [[self.datasourceList allKeys] objectAtIndex:indexPath.row];
        cell.matchTitleLabel.text = key;
        
        id value = [[self.datasourceList allValues] objectAtIndex:indexPath.row];
        if ([value isKindOfClass:[NSString class] ]) {
            cell.matchDescritionLabel.text = value;
        }
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