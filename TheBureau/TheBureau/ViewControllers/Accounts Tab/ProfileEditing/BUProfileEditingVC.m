//
//  BUProfileEditingVC.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileEditingVC.h"
#import "BUProfileBasicInfoCell.h"
#import "BUProfileEducationInfoCell.h"
#import "BUProfileOccupationInfoCell.h"
#import "BUProfileLegalStatusInfoCell.h"
#import "BUProfileHeritageInfoCell.h"
#import "BUProfileSocialHabitsInfoCell.h"
#import "BUProfileHoroscopeInfoCell.h"
#import "BUUtilities.h"
#import "BUConstants.h"

@interface BUProfileEditingVC ()
@property(nonatomic) NSInteger selectedRow;


#pragma mark - Account selection
@property (assign, nonatomic) BOOL shouldExpand,isEditing;
@property (assign, nonatomic) NSIndexPath *selectedCellIndex;


@property (strong, nonatomic) NSMutableDictionary *basicInfoDict,*educationDict,*occupationDict,*heritageDict,*socialHabitsDict,*horoscopeDict;



@end

@implementation BUProfileEditingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedRow = -1;
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Profile";
    // Do any additional setup after loading the view.
    
    self.isEditing = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];

    [super viewWillAppear:animated];
    [BUUtilities removeLogo:self.navigationController];
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    [self getProfileDetails];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [BUUtilities setNavBarLogo:self.navigationController image:[UIImage imageNamed:@"logo44"]];
    self.navigationItem.rightBarButtonItem = nil;
    
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



- (IBAction)editProfileDetails:(id)sender
{
    NSString *imgName = @"";
    if (self.rightBarButton.tag == 0)
    {
        self.isEditing = YES;
        self.rightBarButton.tag = 1;
        imgName = @"ic_done";
    }
    else
    {
        self.rightBarButton.tag = 0;
        imgName = @"ic_edit";
        self.isEditing = NO;
        if (nil != self.selectedCellIndex)
        {
            [[self.profileTableView cellForRowAtIndexPath:self.selectedCellIndex] performSelector:@selector(updateProfile) withObject:nil];
        }
        
        [self updateProfile];
    }
    self.rightBarButton.image = [UIImage imageNamed:imgName];

    [self.profileTableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileBasicInfoCell"];
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileEducationInfoCell"];
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileOccupationInfoCell"];
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileLegalStatusInfoCell"];
            break;
        }
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileHeritageInfoCell"];
            break;
        }
        case 5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileSocialHabitsInfoCell"];
            break;
        }
        case 6:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileHoroscopeInfoCell"];
            break;
        }
        default:
            break;
    }
    //Clip whatever is out the cell frame
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView setUserInteractionEnabled:self.isEditing];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat normalHeight = 80;
    CGFloat expandedHeight = 300;
    CGFloat height = 0;
    
    switch (indexPath.section) {
        case 0:
        {
            expandedHeight = 300;
            break;
        }
        case 1:
        {
            expandedHeight = 380;
            break;
        }
        case 2:
        {
            expandedHeight = 300;
            break;
        }
        case 3:
        {
            expandedHeight = 160;
            break;
        }
        case 4:
        {
            expandedHeight = 330;
            break;
        }
        case 5:
        {
            expandedHeight = 320;
            break;
        }
        case 6:
        {
            expandedHeight = 300;
            break;
        }
        default:
            break;
    }
    height =   (self.selectedRow != indexPath.section) ? normalHeight :expandedHeight;
    if(NO == self.shouldExpand)
        height = normalHeight;
    return height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view endEditing:YES];
    NSString *imgName = @"";
    
    self.rightBarButton.tag = 0;
    imgName = @"ic_edit";
    self.isEditing = NO;
    self.rightBarButton.image = [UIImage imageNamed:imgName];

    if(self.selectedRow == indexPath.section)
    {
        self.shouldExpand = !self.shouldExpand;
    }
    else
    {
        self.shouldExpand = YES;
    }
    self.selectedRow = indexPath.section;
    [self.profileTableView beginUpdates];
    [self.profileTableView endUpdates];
    
   [self performSelector:@selector(scrollToTop:) withObject:indexPath afterDelay:1.0];
    self.selectedCellIndex = indexPath;
}


-(void)scrollToTop:(NSIndexPath *)indexPath
{
    [self.profileTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];


    [self.profileTableView reloadData];
}


-(void)getProfileDetails
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    
    [self startActivityIndicator:YES];

    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:@"http://app.thebureauapp.com/admin/readProfileDetails"
                                         successBlock:^(id response, NSError *error) {
                                             
                                             [self stopActivityIndicator];
                                             
                                         }
                                         failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }];
    
}


-(void)updateProfile
{
    NSDictionary *parameters = nil;
 parameters = @{
        @"college"  :  @"MCE ashkjsd",
        @"company"  :  @"asjhdjksdd",
        @"country_residing" : @"India",
        @"created_by" : @"Self",
        @"current_zip_code" : @"45323437126",
        @"diet" : @"Non Vegetarian",
        @"dob" : @"1996-01-27",
        @"drinking" : @"Never",
        @"email" : @"testedagain@test.com",
        @"employment_status" : @"Student",
        @"family_origin_id" : @"3",
        @"first_name" : @"Manjunath",
        @"gender" : @"Male",
        @"gothra" : @"gothra tested again",
        @"userid": [BUWebServicesManager sharedManager].userID,
        @"graduated_year" : @"2008",
        @"height_feet" : @"6",
        @"height_inch" : @"0",
        @"highest_education" : @"BE",
        @"maritial_status" : @"alskdhsa",
        @"honors" : @"honors" };

    
    
    [self startActivityIndicator:YES];
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:@"http://app.thebureauapp.com/admin/update_profile_ws"
                                         successBlock:^(id response, NSError *error) {
                                             
                                             [self stopActivityIndicator];
                                             
                                         }
                                         failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }];
    

}
@end
