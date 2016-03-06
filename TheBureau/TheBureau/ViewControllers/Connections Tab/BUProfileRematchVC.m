//
//  BUProfileRematchVC.m
//  TheBureau
//
//  Created by Accion Labs on 16/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileRematchVC.h"
#import "BURematchCollectionViewCell.h"
#import "BUUserProfile.h"
#import "BUHomeViewController.h"

@interface BUProfileRematchVC ()

@property(nonatomic) NSArray * imageArray;
@property(nonatomic, strong) NSMutableArray *datasourceList;
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic,weak) IBOutlet UICollectionView *rematchCollectionView;
@property(nonatomic,strong) BUUserProfile *userProfile;
@property(nonatomic, strong) NSMutableArray *userStatus;



@end

@implementation BUProfileRematchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datasourceList = [[NSMutableArray alloc]init];
    _imageArray = [[NSArray alloc]initWithObjects:@"img_photo1",@"img_photo1",@"img_photo1",@"img_photo1", @"img_photo2",@"img_photo2",@"img_photo2",@"img_photo2",nil];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getRematchProfile];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getRematchProfile
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": @"8"
                   };
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] rematchwithParameters:parameters
                                                              successBlock:^(id inResult, NSError *error)
     {
         [self stopActivityIndicator];
         if(nil != inResult && 0 < [inResult count])
         {
             self.datasourceList = inResult;
             
      //      self.userProfile = [[BUUserProfile alloc]initWithUserProfile:inResult];
             
             
             self.imagesList = [[NSMutableArray alloc] init];
             self.userStatus = [[NSMutableArray alloc] init];
             for (NSDictionary *dict in inResult)
             {
                 [self.userStatus addObject:[dict valueForKey:@"user_action"]];

                 if ([[dict valueForKey:@"img_url"] firstObject]) {
                     [self.imagesList addObject:[[dict valueForKey:@"img_url"] firstObject]];
                 }
                 
             }
//Liked Passed
            [self.rematchCollectionView reloadData];
         }
         else
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];              [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
         }
     }
                                                              failureBlock:^(id response, NSError *error)
     {
         [self startActivityIndicator:YES];
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }];
}




#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_imagesList count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   BURematchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BURematchCollectionViewCell" forIndexPath:indexPath];
//    cell.userImageView.image = [UIImage imageNamed:[_imagesList objectAtIndex:indexPath.item]];
    
    [cell setImageURL:[self.imagesList objectAtIndex:indexPath.row]];
    
    NSString *user_status = [self.userStatus objectAtIndex:indexPath.row];
    
    if ([user_status isEqualToString:@"Liked"]) {
        cell.userMatchImageView.image = [UIImage imageNamed:@"btn_liked"];

    }
    else{
        
        cell.userMatchImageView.image = [UIImage imageNamed:@"btn_passed"];

    }
 
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    BUHomeViewController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeViewController"];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat picDimension = self.view.frame.size.width/2;
    if (self.view.frame.size.width == 375) {
        return CGSizeMake(110, 150);
   
    }
    if (self.view.frame.size.width == 320) {
        return CGSizeMake(90, 150);
        
    }
    return CGSizeMake(110, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    //CGFloat leftRightInset = self.view.frame.size.width / 14.0f;
    return UIEdgeInsetsMake(0, 10, 0, 10);
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
