//
//  BUContactListTableViewCell.h
//  TheBureau
//
//  Created by Accion Labs on 26/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUContactListTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView *userImageView;
@property(nonatomic,weak)IBOutlet UILabel *userName;
@property(nonatomic,weak)IBOutlet UILabel *lastmessageLbl;


@end