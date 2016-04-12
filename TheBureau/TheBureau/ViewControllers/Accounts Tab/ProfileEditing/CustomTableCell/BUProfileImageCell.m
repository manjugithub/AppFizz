//
//  BUProfileImageCell.m
//  TheBureau
//
//  Created by Manjunath on 01/04/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileImageCell.h"
#import "BUWebServicesManager.h"
@implementation BUProfileImageCell

- (void)awakeFromNib {
    // Initialization code
    
    self.collectionView.layer.cornerRadius = 10.0;
    self.collectionView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.collectionView.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



- (IBAction)capturePhoto:(id)sender
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil
                                               destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Photo Library",@"Cancel", nil];
    actionSheet.tag = 1000;
    [actionSheet showInView:[self.parentVC view]];
}
#pragma mark - ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 2)
    {
        return;
    }
    else
    {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        if ( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]&& buttonIndex == 0)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        [[self parentVC] presentViewController:imagePicker animated:YES completion:nil];
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *path = [self imageFilePath];
    [imageData writeToFile:path atomically:YES];
    
    if(nil == self.imagesList)
        self.imagesList = [[NSMutableArray alloc] init];
    //[info objectForKey:UIImagePickerControllerEditedImage]
    [self.imagesList addObject:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self.imagesDict setValue:self.imagesList forKey:@"img_url"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.collectionView reloadData];
    
}

-(void)setProfileImageDict:(NSMutableDictionary *)imageDict;
{
    self.imagesDict = imageDict;
    [self setProfileImageList:[self.imagesDict valueForKey:@"img_url"]];
}


-(void)setProfileImageList:(NSArray *)imageListArray
{
    self.imagesList = [[NSMutableArray alloc] initWithArray:imageListArray];
    [self.collectionView reloadData];
}

-(NSString *)imageFilePath
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [dirPaths objectAtIndex:0];
    NSString *docsDir = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[NSDate date] description]]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:docsDir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:docsDir withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return [docsDir stringByAppendingPathComponent:@"tmp.png"];
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 100);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.isEditing)
    {
        return self.imagesList.count;
    }
    else
    {
        return self.imagesList.count + 1;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row < self.imagesList.count)
    {
        BUHomeImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUHomeImagePreviewCell"
                                                                                 forIndexPath:indexPath];
        
        if([[self.imagesList objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
        {
            [cell setImageURL:[self.imagesList objectAtIndex:indexPath.row]];
        }
        else
        {
            [cell.profileImgView setImage:[self.imagesList objectAtIndex:indexPath.row]];
            cell.activityIndicatorView.hidden = YES;
        }
        cell.deleteBtn.tag = indexPath.row;
        
        if(self.isEditing)
        {
            cell.deleteBtn.hidden = NO;
        }
        else
        {
            cell.deleteBtn.hidden = YES;
        }
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddImageCell"
                                                                               forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"collectionView willDisplayCell: %ld",indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    self.imagePreviewVC = [sb instantiateViewControllerWithIdentifier:@"BUImagePreviewVC"];
    self.imagePreviewVC.imagesList = self.imagesList;
    self.imagePreviewVC.indexPathToScroll = indexPath;
    [self.parentVC presentViewController:self.imagePreviewVC animated:NO completion:nil];
}

-(IBAction)deletePicture:(id)sender
{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[sender tag] inSection:0]];

    [UIView animateWithDuration:0.6 animations:^{
        [cell setAlpha:0.0];
    }
                     completion:^(BOOL finished)
     {
         if([[self.imagesList objectAtIndex:[sender tag]] isKindOfClass:[NSString class]])
             [[BUWebServicesManager sharedManager] deleteProfilePicture:[self.imagesList objectAtIndex:[sender tag]]];

         [self.imagesList removeObjectAtIndex:[sender tag]];
         [self.collectionView reloadData];
     }];
}

-(IBAction)editProfilePic:(id)sender
{
    if ([sender tag] == 0)
    {
        self.isEditing = YES;
        [sender setTag:1];
        [(UIButton *)sender setImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    }
    else
    {
        self.isEditing = NO;
        [sender setTag:0];
        [(UIButton *)sender setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    }
    
    [self.collectionView reloadData];

}


-(void)saveProfileImages
{
    for (id pic in self.imagesList)
    {
        if(NO == [pic isKindOfClass:[NSString class]])
            [[BUWebServicesManager sharedManager] uploadProfilePicture:pic];
    }
}

@end
