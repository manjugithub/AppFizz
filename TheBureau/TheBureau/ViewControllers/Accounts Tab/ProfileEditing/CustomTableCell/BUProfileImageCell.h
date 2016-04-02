//
//  BUProfileImageCell.h
//  TheBureau
//
//  Created by Manjunath on 01/04/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUProfileEditingVC.h"
#import "BUHomeImagePreviewCell.h"
#import "BUImagePreviewVC.h"
@interface BUProfileImageCell : UITableViewCell<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(weak, nonatomic) IBOutlet BUBaseViewController *parentVC;

@property(nonatomic, strong) NSMutableArray *imagesList;

@property(nonatomic, strong) NSMutableDictionary *imagesDict;
//img_url

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
-(void)setProfileImageList:(NSArray *)imageListArray;
-(void)setProfileImageDict:(NSMutableDictionary *)imageDict;
@property(weak, nonatomic) BUImagePreviewVC *imagePreviewVC;
@end
