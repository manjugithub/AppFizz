//
//  BUPrefAgeSeekCell.h
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUPrefAgeSeekCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *minValueLabel,*maxValueLabel;
@property(nonatomic, weak) IBOutlet UIView *leftView,*rightView,*overLayView;
@property(nonatomic, assign) BOOL shouldMoveLeftView,shouldMoveRightView;
@property(nonatomic, assign) CGPoint prevLocation,currentLocation;
@property(nonatomic, assign) CGFloat interval;


@property(nonatomic, assign) IBInspectable int cellType;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightViewRightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *minLabelLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maxLabelRightConstraint;

@end
