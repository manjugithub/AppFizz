//
//  BURematchProfileDetailsVC.m
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BURematchProfileDetailsVC.h"
#import "BUHomeProfileImgPrevCell.h"
#import "BUMatchInfoCell.h"
#import "AFHTTPSessionManager.h"

@interface BURematchProfileDetailsVC ()
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;
@property(nonatomic, strong) IBOutlet UIImageView *noProfileImgView;

@property(nonatomic, strong) IBOutlet UIButton *matchBtn,*payBtn;


@end

@implementation BURematchProfileDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.imgScrollerTableView.hidden = YES;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    self.imagesList = [[NSMutableArray alloc] initWithArray:[self.datasourceList valueForKey:@"img_url"]];
    
    [self.imgScrollerTableView reloadData];

}

-(void)viewDidAppear:(BOOL)animated
{
    self.noProfileImgView.hidden = YES;
    NSLog(@"Table view size frame: %@",NSStringFromCGRect(self.imgScrollerTableView.bounds));
    self.imgScrollerTableView.hidden = NO;
//    [self.imgScrollerTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(0 == indexPath.row)
    {
        return self.imgScrollerTableView.frame.size.height;
    }
    return 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.datasourceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(0 == indexPath.row)
    {
        BUHomeProfileImgPrevCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUHomeProfileImgPrevCell"];
        [cell setImagesListToScroll:self.imagesList];
        return cell;
        
    }
    else
    {
        BUMatchInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUMatchInfoCell"];
        NSString *key = [[self.datasourceList allKeys] objectAtIndex:indexPath.row];
        cell.matchTitleLabel.text = key;
        
        id value = [[self.datasourceList allValues] objectAtIndex:indexPath.row];
        if ([value isKindOfClass:[NSString class] ]) {
            cell.matchDescritionLabel.text = value;
        }
        return cell;
    }
    return nil;
}

-(IBAction)match:(id)sender
{
    [self stopActivityIndicator];
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"You have the ability to connect with past matches, click on a match to view their profile"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Rematch" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            self.matchBtn.hidden = YES;
            self.payBtn.hidden = NO;
        }];
        
        action;
    })];
    
    [self presentViewController:alertController  animated:YES completion:nil];
    
}


-(IBAction)payAndMatch:(id)sender
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid1": [BUWebServicesManager sharedManager].userID,
                   @"userid2": [self.datasourceList valueForKey:@"userid"],
                   @"gold_amount": @"500"
                   };
    
    [self startActivityIndicator:YES];
    [self matchWithparameters:parameters];
    
}
-(void)matchWithparameters:(NSDictionary *)inParams;
{
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/isMatched";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self stopActivityIndicator];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Your interest is sent!"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 
                 self.payBtn.hidden = YES;
             }];
             
             action;
         })];
         
         [self presentViewController:alertController  animated:YES completion:nil];
         
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self stopActivityIndicator];
         NSLog(@"Error: %@", error);
     }];
}


@end
