//
//  BUHomeProfileImgPrevCell.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeProfileImgPrevCell.h"
#import "BUHomeCollectionVC.h"

@interface BUHomeProfileImgPrevCell ()
@property(nonatomic, strong) IBOutlet BUHomeCollectionVC *imgCollectionVC;
@end

@implementation BUHomeProfileImgPrevCell

- (void)awakeFromNib {
    // Initialization code
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    self.imgCollectionVC = [sb instantiateViewControllerWithIdentifier:@"BUHomeCollectionVC"];
    [self.contentView addSubview:self.imgCollectionVC.view];

    self.imgCollectionVC.collectionView.dataSource = self.imgCollectionVC;
    self.imgCollectionVC.collectionView.delegate = self.imgCollectionVC;
}

-(void)layoutSubviews
{
    NSLog(@"%@",NSStringFromCGRect(self.contentView.bounds));
    self.imgCollectionVC.view.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)setImagesListToScroll:(NSMutableArray *)inImageList
{
    [self.imgCollectionVC.collectionView reloadData];
}

@end
