//
//  BUChattinProfileDetailsVC.m
//  TheBureau
//
//  Created by Manjunath on 21/06/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUChattinProfileDetailsVC.h"
#import "BUHomeProfileImgPrevCell.h"
#import "BUMatchInfoCell.h"
#import "AFHTTPSessionManager.h"
#import "BUAboutMeCell.h"
#import "BUWebServicesManager.h"
@interface BUChattinProfileDetailsVC ()
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;
@property(nonatomic, strong) IBOutlet UIImageView *noProfileImgView;
@property(nonatomic, strong) NSMutableArray *keysList;

@property(nonatomic, strong) IBOutlet UIButton *matchBtn,*payBtn;


@end

@implementation BUChattinProfileDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgScrollerTableView.hidden = YES;
    
}


-(void)cookupDataSource
{
    self.imagesList = [[NSMutableArray alloc] initWithArray:[self.datasourceList valueForKey:@"img_url"]];
    
    NSDictionary *respDict = self.datasourceList;
    
    self.keysList = [[NSMutableArray alloc] init];
    
    //    NSString *profileName = [NSString stringWithFormat:@"%@ %@",[respDict valueForKey:@"profile_first_name"],[respDict valueForKey:@"profile_last_name"]];
    
    //    [self.datasourceList setValue:[respDict valueForKey:@"created_by"] forKey:@"Profile created by"];
    //    [self.keysList addObject:@"Profile created by"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"age"] forKey:@"Age"];
    [self.keysList addObject:@"Age"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"location"] forKey:@"Location"];
    [self.keysList addObject:@"Location"];
    
    
    NSString *height = [NSString stringWithFormat:@"%@' %@\"",[respDict valueForKey:@"height_feet"],[respDict valueForKey:@"height_inch"]];
    [self.datasourceList setValue:height forKey:@"Height"];
    [self.keysList addObject:@"Height"];
    
    
    [self.datasourceList setValue:[respDict valueForKey:@"mother_tongue"] forKey:@"Mother Toungue"];
    [self.keysList addObject:@"Mother Toungue"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"religion_name"] forKey:@"Religion"];
    [self.keysList addObject:@"Religion"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"family_origin_name"] forKey:@"Family Origin"];
    [self.keysList addObject:@"Family Origin"];
    
    [self.datasourceList setValue:@"" forKey:@"Specification"];
    [self.keysList addObject:@"Specification"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"highest_education"] forKey:@"Education"];
    [self.keysList addObject:@"Education"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"honors"] forKey:@"Honors"];
    [self.keysList addObject:@"Honors"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"major"] forKey:@"Major"];
    [self.keysList addObject:@"Major"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"college"] forKey:@"College"];
    [self.keysList addObject:@"College"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"graduated_year"] forKey:@"Year"];
    [self.keysList addObject:@"Year"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"employment_status"] forKey:@"Occupation"];
    [self.keysList addObject:@"Occupation"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"company"] forKey:@"Employer"];
    [self.keysList addObject:@"Employer"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"diet"] forKey:@"Diet"];
    [self.keysList addObject:@"Diet"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"smoking"] forKey:@"Smoking"];
    [self.keysList addObject:@"Smoking"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"drinking"] forKey:@"Drinking"];
    [self.keysList addObject:@"Drinking"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"years_in_usa"] forKey:@"Years in USA"];
    [self.keysList addObject:@"Years in USA"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"legal_status"] forKey:@"Legal Status"];
    [self.keysList addObject:@"Legal Status"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"profile_dob"] forKey:@"Date of Birth"];
    [self.keysList addObject:@"Date of Birth"];
    
    [self.datasourceList setValue:@"" forKey:@"Time of Birth"];
    [self.keysList addObject:@"Time of Birth"];
    
    [self.datasourceList setValue:[respDict valueForKey:@"about_me"] forKey:@"About Me"];
    [self.keysList addObject:@"About Me"];
    
    //    [self.collectionView reloadData];
    [self.imgScrollerTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    self.imagesList = [[NSMutableArray alloc] initWithArray:[self.datasourceList valueForKey:@"img_url"]];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.noProfileImgView.hidden = YES;
    NSLog(@"Table view size frame: %@",NSStringFromCGRect(self.imgScrollerTableView.bounds));
    self.imgScrollerTableView.hidden = NO;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(0 == indexPath.row)
    {
        return self.imgScrollerTableView.frame.size.height;
    }
    return 20;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.keysList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(0 == indexPath.row)
    {
        BUHomeProfileImgPrevCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUHomeProfileImgPrevCell"];
        [cell setImagesListToScroll:self.imagesList];
        return cell;
        
    }
    if(self.keysList.count  == indexPath.row)
    {
        BUAboutMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUAboutMeCell"];
        NSString *key = [self.keysList objectAtIndex:indexPath.row - 1];
        
        
        {
            cell.matchTitleLabel.text = [NSString stringWithFormat:@"    %@",key];
        }
        cell.aboutMeDetailTV.text = [NSString stringWithFormat:@"%@",[self.datasourceList valueForKey:key]];
        return cell;
    }
    else
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
    return nil;
}




-(void)getProfileDetails
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": self.profileID};
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] getProfileDetailsWithParameters:parameters successBlock:^(id response, NSError *error) {
        [self stopActivityIndicator];
        self.datasourceList = [[NSMutableDictionary alloc] initWithDictionary:response];
        [self performSelector:@selector(cookupDataSource) withObject:nil afterDelay:1.5];
    } failureBlock:^(id response, NSError *error) {
        [self stopActivityIndicator];
    }];
    
}


@end
