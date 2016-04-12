//
//  BUProfileEditingVC.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileEditingVC.h"
#import "BUProfileImageCell.h"
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
@property (assign, nonatomic) BUProfileImageCell *profileImageCell;


@property (strong, nonatomic) NSMutableDictionary *profileImageDict,*basicInfoDict,*educationDict,*occupationDict,*heritageDict,*socialHabitsDict,*horoscopeDict,*legalStatus;



@end

@implementation BUProfileEditingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedRow = -1;
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Profile";
    // Do any additional setup after loading the view.
    [self getProfileDetails];
    self.isEditing = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];

    [super viewWillAppear:animated];
    [BUUtilities removeLogo:self.navigationController];
//    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(editProfileDetails:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:UIKeyboardWillHideNotification object:nil];

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
    [self updateProfile];
//    [self.profileTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileImageCell"];
            [(BUProfileImageCell *)cell setProfileImageDict:self.profileImageDict];
            self.profileImageCell = (BUProfileImageCell *)cell;
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileBasicInfoCell"];
            
            [(BUProfileBasicInfoCell *)cell setDatasource:self.basicInfoDict];
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileEducationInfoCell"];
            [(BUProfileEducationInfoCell *)cell setDatasource:self.educationDict];
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileOccupationInfoCell"];
            [(BUProfileOccupationInfoCell *)cell setDatasource:self.occupationDict];
            break;
        }
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileLegalStatusInfoCell"];
            [(BUProfileLegalStatusInfoCell *)cell setDatasource:self.legalStatus];
            break;
        }
        case 5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileHeritageInfoCell"];
            [(BUProfileHeritageInfoCell *)cell setDatasource:self.heritageDict];
            break;
        }
        case 6:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileSocialHabitsInfoCell"];
            [(BUProfileSocialHabitsInfoCell *)cell setDatasource:self.socialHabitsDict];
            break;
        }
        case 7:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUProfileHoroscopeInfoCell"];
            [(BUProfileHoroscopeInfoCell *)cell setDatasource:self.horoscopeDict];
            break;
        }
        default:
            break;
    }
    //Clip whatever is out the cell frame
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [cell.contentView setUserInteractionEnabled:self.isEditing];
    
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
            expandedHeight = 200;
            break;
        }
        case 1:
        {
            expandedHeight = 390;
            break;
        }
        case 2:
        {
            expandedHeight = 380;
            break;
        }
        case 3:
        {
            expandedHeight = 300;
            break;
        }
        case 4:
        {
            expandedHeight = 487;
            break;
        }
        case 5:
        {
            expandedHeight = 330;
            break;
        }
        case 6:
        {
            expandedHeight = 320;
            break;
        }
        case 7:
        {
            expandedHeight = 350;
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

-(IBAction)hideShowDetails:(id)inSender
{
    
    [self.view endEditing:YES];
    NSString *imgName = @"";
    
    self.rightBarButton.tag = 0;
    imgName = @"ic_edit";
    self.isEditing = NO;
    self.rightBarButton.image = [UIImage imageNamed:imgName];
    
    if(self.selectedRow == [inSender tag])
    {
        self.shouldExpand = !self.shouldExpand;
    }
    else
    {
        self.shouldExpand = YES;
    }
    self.selectedRow = [inSender tag];
    [self.profileTableView beginUpdates];
    [self.profileTableView endUpdates];
    
    self.selectedCellIndex = [NSIndexPath indexPathForRow:0 inSection:[inSender tag]];
    
    [self performSelector:@selector(scrollToTop:) withObject:self.selectedCellIndex afterDelay:1.0];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    [self.view endEditing:YES];
//    NSString *imgName = @"";
//    
//    self.rightBarButton.tag = 0;
//    imgName = @"ic_edit";
//    self.isEditing = NO;
//    self.rightBarButton.image = [UIImage imageNamed:imgName];
//
//    if(self.selectedRow == indexPath.section)
//    {
//        self.shouldExpand = !self.shouldExpand;
//    }
//    else
//    {
//        self.shouldExpand = YES;
//    }
//    self.selectedRow = indexPath.section;
//    [self.profileTableView beginUpdates];
//    [self.profileTableView endUpdates];
//    
//   [self performSelector:@selector(scrollToTop:) withObject:indexPath afterDelay:1.0];
//    self.selectedCellIndex = indexPath;
//}


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

    
/*
 
 
 {
 age = 0;
 college = "MCE ashkjsd";
 company = asjhdjksdd;
 "country_residing" = India;
 "created_by" = Mother;
 "current_zip_code" = 45323437126;
 diet = "Non Vegetarian";
 dob = "2016-01-27";
 drinking = Never;
 email = "test@test.com";
 "employment_status" = Student;
 "family_origin_id" = 3;
 "family_origin_name" = Vaishya;
 "first_name" = aa;
 gender = Male;
 gothra = "gothra tested again";
 "graduated_year" = 2008;
 "height_feet" = 6;
 "height_inch" = 0;
 "highest_education" = "";
 honors = honors;
 "horoscope_path" = "http://app.thebureauapp.com/user_horoscope/8/pdf-sample.pdf";
 id = 54;
 "last_name" = vv;
 latitude = "22.3159047";
 "legal_status" = "<null>";
 location = "<null>";
 longitude = "-97.8549341";
 major = "<null>";
 "maritial_status" = "";
 "mother_tongue" = "<null>";
 "mother_tongue_id" = 0;
 "other_legal_status" = "<null>";
 "phone_number" = 0009898765;
 "position_title" = "<null>";
 "profile_dob" = "1969-12-31";
 "profile_first_name" = "<null>";
 "profile_for" = "<null>";
 "profile_gender" = "";
 "profile_last_name" = "<null>";
 "religion_id" = 0;
 "religion_name" = "<null>";
 smoking = "";
 "specification_id" = 0;
 "user_status" = "";
 userid = 8;
 "years_in_usa" = "<null>";
 }

*/
 
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:@"http://app.thebureauapp.com/admin/readProfileDetails"
                                         successBlock:^(id response, NSError *error) {
                                             
                                             [self stopActivityIndicator];

                                             NSDictionary *respDict = response;
                                             
                                             self.profileImageDict = [[NSMutableDictionary alloc] init];
                                             
                                             
                                             [self.profileImageDict setValue:([respDict valueForKey:@"img_url"] != nil && NO == [[respDict valueForKey:@"img_url"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"img_url"] : [respDict valueForKey:@"img_url"] forKey:@"img_url"];
                                             self.basicInfoDict = [[NSMutableDictionary alloc] init];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"profile_first_name"] != nil && NO == [[respDict valueForKey:@"profile_first_name"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"profile_first_name"] : [respDict valueForKey:@"profile_first_name"] forKey:@"profile_first_name"];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"profile_dob"] != nil && NO == [[respDict valueForKey:@"profile_dob"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"profile_dob"] : @""  forKey:@"profile_dob"];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"gender"] != nil && NO == [[respDict valueForKey:@"gender"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"gender"] : @""  forKey:@"gender"];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"current_zip_code"] != nil && NO == [[respDict valueForKey:@"current_zip_code"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@""] : @""  forKey:@"current_zip_code"];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"height_feet"] != nil && NO == [[respDict valueForKey:@"height_feet"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"height_feet"] : @""  forKey:@"height_feet"];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"height_inch"] != nil && NO == [[respDict valueForKey:@"height_inch"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"height_inch"] : @""  forKey:@"height_inch"];
                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"maritial_status"] != nil && NO == [[respDict valueForKey:@"maritial_status"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"maritial_status"] : @""  forKey:@"maritial_status"];

                                             
                                             [self.basicInfoDict setValue:([respDict valueForKey:@"current_zip_code"] != nil && NO == [[respDict valueForKey:@"current_zip_code"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"current_zip_code"] : @""  forKey:@"current_zip_code"];

                                             
                                             
                                             self.educationDict = [[NSMutableDictionary alloc] init];
                                             [self.educationDict setValue:([respDict valueForKey:@"highest_education"] != nil && NO == [[respDict valueForKey:@"highest_education"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"highest_education"] : @""  forKey:@"highest_education"];
                                             
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"honors"] != nil && NO == [[respDict valueForKey:@"honors"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"honors"] : @""  forKey:@"honors"];
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"major"] != nil && NO == [[respDict valueForKey:@"major"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"major"] : @""  forKey:@"major"];
                                             
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"college"] != nil && NO == [[respDict valueForKey:@"college"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"college"] : @""  forKey:@"college"];
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"graduated_year"] != nil && NO == [[respDict valueForKey:@"graduated_year"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"graduated_year"] : @""  forKey:@"graduated_year"];


                                             [self.educationDict setValue:([respDict valueForKey:@"education_second"] != nil && NO == [[respDict valueForKey:@"education_second"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"education_second"] : @""  forKey:@"education_second"];
                                             
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"honors_second"] != nil && NO == [[respDict valueForKey:@"honors_second"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"honors_second"] : @""  forKey:@"honors_second"];
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"majors_second"] != nil && NO == [[respDict valueForKey:@"majors_second"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"majors_second"] : @""  forKey:@"majors_second"];
                                             
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"college_second"] != nil && NO == [[respDict valueForKey:@"college_second"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"college_second"] : @""  forKey:@"college_second"];
                                             
                                             [self.educationDict setValue:([respDict valueForKey:@"graduation_years_second"] != nil && NO == [[respDict valueForKey:@"graduation_years_second"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"graduation_years_second"] : @""  forKey:@"graduation_years_second"];
                                             

                                             
                                             self.occupationDict = [[NSMutableDictionary alloc] init];
                                             [self.occupationDict setValue:([respDict valueForKey:@"employment_status"] != nil && NO == [[respDict valueForKey:@"employment_status"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"employment_status"] : @""  forKey:@"employment_status"];
                                             
                                             [self.occupationDict setValue:([respDict valueForKey:@"position_title"] != nil && NO == [[respDict valueForKey:@"position_title"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"position_title"] : @""  forKey:@"position_title"];
                                             
                                             

                                             [self.occupationDict setValue:([respDict valueForKey:@"company"] != nil && NO == [[respDict valueForKey:@"company"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"company"] : @""  forKey:@"company"];
                                             
                                             self.heritageDict = [[NSMutableDictionary alloc] init];
                                             [self.heritageDict setValue:([respDict valueForKey:@"religion_id"] != nil && NO == [[respDict valueForKey:@"religion_id"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"religion_id"] : @""  forKey:@"religion_id"];

                                             [self.heritageDict setValue:([respDict valueForKey:@"family_origin_name"] != nil && NO == [[respDict valueForKey:@"family_origin_name"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"family_origin_name"] : @""  forKey:@"family_origin_name"];

                                             [self.heritageDict setValue:([respDict valueForKey:@"gothra"] != nil && NO == [[respDict valueForKey:@"gothra"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"gothra"] : @""  forKey:@"gothra"];

                                             [self.heritageDict setValue:([respDict valueForKey:@"mother_tongue"] != nil && NO == [[respDict valueForKey:@"mother_tongue"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"mother_tongue"] : @""  forKey:@"mother_tongue"];

                                             [self.heritageDict setValue:([respDict valueForKey:@"religion_name"] != nil && NO == [[respDict valueForKey:@"religion_name"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"religion_name"] : @""  forKey:@"religion_name"];

                                             
                                             [self.heritageDict setValue:([respDict valueForKey:@"mother_tongue_id"] != nil && NO == [[respDict valueForKey:@"mother_tongue_id"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"mother_tongue_id"] : @""  forKey:@"mother_tongue_id"];
                                             
                                             [self.heritageDict setValue:([respDict valueForKey:@"family_origin_id"] != nil && NO == [[respDict valueForKey:@"family_origin_id"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"family_origin_id"] : @""  forKey:@"family_origin_id"];
                                             
                                             [self.heritageDict setValue:([respDict valueForKey:@"specification_id"] != nil && NO == [[respDict valueForKey:@"specification_id"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"specification_id"] : @""  forKey:@"specification_id"];

                                             [self.heritageDict setValue:([respDict valueForKey:@"specification_name"] != nil && NO == [[respDict valueForKey:@"specification_name"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"specification_name"] : @""  forKey:@"specification_name"];


                                             self.socialHabitsDict = [[NSMutableDictionary alloc] init];
                                             [self.socialHabitsDict setValue:([respDict valueForKey:@"diet"] != nil && NO == [[respDict valueForKey:@"diet"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"diet"] : @""  forKey:@"diet"];
                                             
                                             [self.socialHabitsDict setValue:([respDict valueForKey:@"drinking"] != nil && NO == [[respDict valueForKey:@"drinking"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"drinking"] : @""  forKey:@"drinking"];
                                             
                                             [self.socialHabitsDict setValue:([respDict valueForKey:@"smoking"] != nil && NO == [[respDict valueForKey:@"smoking"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"smoking"] : @""  forKey:@"smoking"];
                                             
                                             
                                             self.legalStatus = [[NSMutableDictionary alloc] init];
                                             [self.legalStatus setValue:([respDict valueForKey:@"years_in_usa"] != nil && NO == [[respDict valueForKey:@"years_in_usa"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"years_in_usa"] : @""  forKey:@"years_in_usa"];
                                             
                                             [self.legalStatus setValue:([respDict valueForKey:@"legal_status"] != nil && NO == [[respDict valueForKey:@"legal_status"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"legal_status"] : @""  forKey:@"legal_status"];
                                             
                                             
                                             
                                             
                                             self.horoscopeDict = [[NSMutableDictionary alloc] init];

                                             [self.horoscopeDict setValue:([respDict valueForKey:@"horoscope_dob"] != nil && NO == [[respDict valueForKey:@"horoscope_dob"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"horoscope_dob"] : @""  forKey:@"horoscope_dob"];

                                             [self.horoscopeDict setValue:([respDict valueForKey:@"horoscope_tob"] != nil && NO == [[respDict valueForKey:@"horoscope_tob"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"horoscope_tob"] : @""  forKey:@"horoscope_tob"];

                                             [self.horoscopeDict setValue:([respDict valueForKey:@"horoscope_lob"] != nil && NO == [[respDict valueForKey:@"horoscope_lob"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"horoscope_lob"] : @""  forKey:@"horoscope_lob"];

                                             [self.horoscopeDict setValue:([respDict valueForKey:@"about_me"] != nil && NO == [[respDict valueForKey:@"about_me"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"about_me"] : @""  forKey:@"about_me"];
                                             
                                             [self.horoscopeDict setValue:([respDict valueForKey:@"horoscope_path"] != nil && NO == [[respDict valueForKey:@"horoscope_path"] isKindOfClass:[NSNull class]]) ?  [respDict valueForKey:@"horoscope_path"] : @""  forKey:@"horoscope_path"];
                                             
                                             
                                             
                                             [self.profileTableView reloadData];
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
    
    [self.profileImageCell saveProfileImages];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];

    [parameters addEntriesFromDictionary:self.basicInfoDict];
    [parameters addEntriesFromDictionary:self.educationDict];
    [parameters addEntriesFromDictionary:self.occupationDict];
    [parameters addEntriesFromDictionary:self.horoscopeDict];
    [parameters addEntriesFromDictionary:self.socialHabitsDict];
    [parameters addEntriesFromDictionary:self.legalStatus];
    [parameters addEntriesFromDictionary:self.heritageDict];
    [parameters setValue:[BUWebServicesManager sharedManager].userID forKey:@"userid"];
    
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

-(void)showKeyboard
{
    CGFloat constant = 0;
    constant = 280;
    self.tableBottomConstraint.constant = constant;
//    [self.profileTableView scrollToRowAtIndexPath:self.selectedCellIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)hideKeyBoard
{
    CGFloat constant = 0;
    self.tableBottomConstraint.constant = constant;
//    [self.profileTableView scrollToRowAtIndexPath:self.selectedCellIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
