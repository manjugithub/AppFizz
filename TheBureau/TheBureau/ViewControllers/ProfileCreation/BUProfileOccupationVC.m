//
//  BUProfileOccupationVC.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileOccupationVC.h"
#import "EmployementStatusTVCell.h"
#import "HighLevelEducationTVCell.h"
#import "BUProfileLegalStatusVC.h"
#import "BUHomeTabbarController.h"
#import "Localytics.h"
#import "BUReferalVC.h"
@interface BUProfileOccupationVC ()<UITableViewDataSource,UITableViewDelegate, HighLevelEducationTVCellDelegate,EmployementStatusTVCellDelegate,UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSInteger tableViewDataSource;
@property (nonatomic) CGFloat employementTVCellHeight;
@property (nonatomic) CGFloat highLevelEducationTVCellHeight;

@property(nonatomic) NSArray *educationLevelArray;

@property(nonatomic) NSIndexPath *selectedIndexpath;

@property(nonatomic) UITextField *currentTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBtmConstraint;

@end

@implementation BUProfileOccupationVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Occupation";
    
    _educationLevelArray = [[NSArray alloc]initWithObjects:@"Doctorate",@"Masters",@"Bachelors",@"Associates",@"Grade School", nil];
    [self loadUI];
    [self loadData];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(viewPopOnBackButton)];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.dataSourceDict = [[NSMutableDictionary alloc] init];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void) hideKeyboard {
    
    [self.currentTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI

- (void)loadUI
{
    self.tableView.dataSource   = self;
    self.tableView.delegate     = self;
}

- (void)loadData
{
    self.tableViewDataSource            = 2;
    self.employementTVCellHeight        = 170.0;
    self.highLevelEducationTVCellHeight = 65.0;
}

#pragma mark - Table View Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDataSource;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellToReturn = nil;
    if (indexPath.row == 0)
    {
        static NSString *employementCellIdentifier = @"EmployementStatusTVCell";
        EmployementStatusTVCell *cell = [tableView dequeueReusableCellWithIdentifier:employementCellIdentifier];
        cell.delegate = self;
        cell.dataSourceDict = self.dataSourceDict;
        cellToReturn = cell;
    }
    else
    {
        static NSString *educationCellIdentifier = @"HighLevelEducationTVCell";
        HighLevelEducationTVCell *cell = [tableView dequeueReusableCellWithIdentifier:educationCellIdentifier];
        cell.indexpath = indexPath;
        cell.educationLevel = indexPath.row;
        if(indexPath.row >= 2)
            cell.addEducationLevelBtn.hidden = YES;
        cell.delegate = self;
        cell.dataSourceDict = self.dataSourceDict;
        cellToReturn = cell;
    }
    
    return cellToReturn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    if (indexPath.row == 0)
    {
        height = self.employementTVCellHeight;
    }
    else
    {
        height = self.highLevelEducationTVCellHeight;
    }
    return height;
}


#pragma mark - textField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.currentTextField = textField;
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentTextField = textField;
}

#pragma mark - HighLevelEducationTVCellDelegate

- (void)addNextLevelButtonTapped
{
    self.tableViewDataSource++;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.tableViewDataSource - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)updateHighLevelEducationTVCell:(NSIndexPath *)indexpath
{
    self.selectedIndexpath = indexpath;
    self.highLevelEducationTVCellHeight = 387.0;
    [self.tableView reloadData];
    [self selectEducationLevel];
}

#pragma mark - EmployementStatusTVCellDelegate

- (void)updateEmployementCellHeightForOthers
{
    self.employementTVCellHeight = 170.0;
    [self.tableView reloadData];
}

- (void)updateEmployementCellHeightForEmployed
{
    self.employementTVCellHeight = 270.0;
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)selectEducationLevel{
UIActionSheet *acSheet = [[UIActionSheet alloc] initWithTitle:@"Select Education Level" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];

for (NSString *str in _educationLevelArray)
{
    [acSheet addButtonWithTitle:str];
}

[acSheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
HighLevelEducationTVCell *cell =(HighLevelEducationTVCell*) [_tableView cellForRowAtIndexPath:_selectedIndexpath];
        
        cell.educationlevelLbl.text = _educationLevelArray[buttonIndex - 1];
        if(cell.educationLevel == 1)
            [self.dataSourceDict setValue:cell.educationlevelLbl.text forKey:@"highest_education"];
        else
            [self.dataSourceDict setValue:cell.educationlevelLbl.text forKey:@"education_second"];

    }
}


-(IBAction)continueClicked:(id)sender
{
    /*
    
    userid => user id of user
    employment_status=> e.g. Employed, Unemployed
    position_title => position title
    company => company name
    highest_education=> e.g. Doctorate, Masters
    honors=> honors (text)
    major=> major
    college=> college
    graduated_year=> graduated year
    education_second => secondary education
    honors_second => honors (if second education is there)
    majors_second => major
    college_second => college
    graduation_years_second => graduation year
*/
    
    [self.dataSourceDict setValue:[BUWebServicesManager sharedManager].userID forKey:@"userid"];
    
//    NSDictionary *parameters = nil;
//    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
//                   @"diet":self.dieting,
//                   @"drinking":self.drink,
//                   @"smoking":self.smoke
//                   };
    
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager]queryServer:self.dataSourceDict
                                             baseURL:@"http://dev.thebureauapp.com/admin/update_profile_step5"
                                        successBlock:^(id response, NSError *error)
     {
         
         [self stopActivityIndicator];
         if([[NSUserDefaults standardUserDefaults] boolForKey:@"isUSCitizen"])
         {
             UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
             BUProfileLegalStatusVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileLegalStatusVC"];
             [self.navigationController pushViewController:vc animated:YES];
         }
         else
         {
             [Localytics tagEvent:@"Login Successful"];
             [Localytics setCustomerId:[BUWebServicesManager sharedManager].userID];;

             
             BUReferalVC *referalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BUReferalVC"];
             [self.navigationController pushViewController:referalVC animated:YES];
             
         }
         
     }
                                        failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         [self showFailureAlert];
     }];
    
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self slideTableDown];
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self slideTableDown];
    [self.view endEditing:YES];
}

-(void)viewPopOnBackButton {
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Do you wish to leave this appication? Your Information has not been saved"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController setValue:message forKey:@"attributedTitle"];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
            //NSLog(@"%@",picker.date);
            
        }];
        
        action;
    })];
    
    [self presentViewController:alertController  animated:YES completion:nil];
}


-(void)slideTableUp
{
    self.tableBtmConstraint.constant = 250;
    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)slideTableDown
{
    self.tableBtmConstraint.constant = 48;
    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
