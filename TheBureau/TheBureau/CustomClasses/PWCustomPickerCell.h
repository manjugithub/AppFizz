//
//  PWCustomPickerCell.h
//  PerfectWellness
//
//  Created by Apple on 19/04/15.
//
//

#import <UIKit/UIKit.h>

@interface PWCustomPickerCell : UITableViewCell
@property (assign, nonatomic) id parentDelegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *radioBtnImgView;
+(PWCustomPickerCell *)createPWCustomPickerCell;
-(void)setDatasource:(NSMutableDictionary *)inDataSourceDict;

@end
