//
//  PWCustomPickerView.h
//  PerfectWellness
//
//  Created by Apple on 19/04/15.
//
//

#import <UIKit/UIKit.h>
#import "BUBaseViewController.h"
@protocol PWPickerViewDelegate;

@interface PWCustomPickerView : BUBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *pickerOverLay;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *pickerTableView;
@property (nonatomic, assign) id <PWPickerViewDelegate> delegate;
@property (nonatomic) eHeritageList selectedHeritage;
@property (strong, nonatomic) NSMutableArray *pickerDataSource;
- (IBAction)closePickerView:(id)sender;
+(PWCustomPickerView *)createCustomPickerView;
-(void)showCusptomPickeWithDelegate:(id<PWPickerViewDelegate>) inDelegate;

@end


@protocol PWPickerViewDelegate
- (void)didItemSelected:(NSMutableDictionary *)inSelectedRow;
@end
