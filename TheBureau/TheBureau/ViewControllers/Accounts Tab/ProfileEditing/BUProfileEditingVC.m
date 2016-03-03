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
@interface BUProfileEditingVC ()
@property(nonatomic) NSInteger selectedRow;
@end

@implementation BUProfileEditingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedRow = -1;
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Profile";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BUUtilities removeLogo:self.navigationController];
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
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
        self.rightBarButton.tag = 1;
        imgName = @"ic_done";
    }
    else
    {
        self.rightBarButton.tag = 0;
        imgName = @"ic_edit";
    }
    self.rightBarButton.image = [UIImage imageNamed:imgName];
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
            expandedHeight = 195;
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
    height =  self.selectedRow != indexPath.section ? normalHeight :expandedHeight;
    return height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.section;
    [self.profileTableView beginUpdates];
    [self.profileTableView endUpdates];

}





@end
