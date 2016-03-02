//
//  BUProfileHeritageInfoCell.h
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUProfileEditingVC.h"
#import "PWCustomPickerView.h"
@interface BUProfileHeritageInfoCell : UITableViewCell<PWPickerViewDelegate,UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet BUProfileEditingVC *parentVC;

@property(nonatomic, strong) PWCustomPickerView *customPickerView;
@property(nonatomic, strong) NSString *religionID,*famliyID,*specificationID,*motherToungueID;

@property(nonatomic, strong) IBOutlet UITextField *religionTF,*motherToungueTF,*specificationTF,*gothraTF,*familyOriginTF;

@property(nonatomic) eHeritageList heritageList;
@property(nonatomic, assign) BOOL isUpdatingProfile;
@end
