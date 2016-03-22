//
//  EmployementStatusCellTableViewCell.h
//  SampleUI
//
//  Created by Sarath Neeravallil Sasi on 04/02/16.
//  Copyright © 2016 Sarath Neeravallil Sasi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmployementStatusTVCellDelegate <NSObject>

- (void)updateEmployementCellHeightForEmployed;
- (void)updateEmployementCellHeightForOthers;


@end

@interface EmployementStatusTVCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *unemployedYConstraint;

@property (weak, nonatomic) IBOutlet UIView *employmentDetailView;
@property (weak, nonatomic) IBOutlet UIButton *employedBtn;
@property (weak, nonatomic) IBOutlet UIButton *unemployedBtn;

@property (weak, nonatomic) IBOutlet UIButton *studentBtn;
@property (weak, nonatomic) IBOutlet UIButton *othersBtn;
@property(nonatomic) NSMutableDictionary *dataSourceDict;




@property (nonatomic,assign) id <EmployementStatusTVCellDelegate> delegate;


@end
