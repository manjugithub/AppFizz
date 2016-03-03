//
//  BUProfileBasicInfoCell.h
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUProfileEditingVC.h"

@interface BUProfileBasicInfoCell : UITableViewCell<UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(weak, nonatomic) IBOutlet UIView *nonEditingView,*editingView;
@property(weak, nonatomic) IBOutlet BUProfileEditingVC *parentVC;

#pragma mark -
#pragma mark - Gender selection
@property(nonatomic,weak) IBOutlet UIImageView *femaleImgView,*maleImgView;
@property(nonatomic,weak) IBOutlet UIButton *genderSelectionBtn;
-(IBAction)setGender:(id)sender;

#pragma mark -
#pragma mark - Height Information

@property(nonatomic) NSMutableArray *feetMutableArray;
@property(nonatomic) NSMutableArray *inchesMutableArray;
@property(nonatomic,weak) NSString *feetStr,*inchStr,*maritalStatus;
@property (weak, nonatomic) IBOutlet UITextField *heighTextField;


@end
