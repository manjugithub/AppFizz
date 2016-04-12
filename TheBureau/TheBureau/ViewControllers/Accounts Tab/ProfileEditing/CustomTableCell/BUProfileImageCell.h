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

@property(nonatomic, assign) BOOL isEditing;


@property(nonatomic, strong) NSMutableDictionary *imagesDict;
//img_url

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;

-(IBAction)deletePicture:(id)sender;


-(IBAction)editProfilePic:(id)sender;

-(void)setProfileImageList:(NSArray *)imageListArray;
-(void)setProfileImageDict:(NSMutableDictionary *)imageDict;
-(void)saveProfileImages;
@property(weak, nonatomic) BUImagePreviewVC *imagePreviewVC;
@end
