//
//  BUHomeViewController.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeViewController.h"
#import "BUHomeProfileImgPrevCell.h"
#import "BUMatchInfoCell.h"
#import "AFHTTPSessionManager.h"
@interface BUHomeViewController ()
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;
@property(nonatomic, strong) NSDictionary *datasourceList;
@property(nonatomic, strong) IBOutlet UIImageView *noProfileImgView;

@property(nonatomic, strong) IBOutlet UIButton *matchBtn,*passBtn;

@end

@implementation BUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.imagesList = [NSMutableArray arrayWithObjects:@"1",@"5",@"4",@"3",@"2", nil];
    self.datasourceList = nil;
    // Do any additional setup after loading the view.
    
    self.imgScrollerTableView.hidden = YES;

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.noProfileImgView.hidden = NO;
    NSLog(@"Table view size frame: %@",NSStringFromCGRect(self.imgScrollerTableView.bounds));
    self.imgScrollerTableView.hidden = NO;
    [self.imgScrollerTableView reloadData];
    [self getMatchMakingfortheDay];
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


-(void)getMatchMakingfortheDay
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": @"8"
                   };
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] matchMakingForTheDaywithParameters:parameters successBlock:^(id response, NSError *error) {
        [self stopActivityIndicator];
        if(nil != response && 0 < [response count])
        {
            
            self.noProfileImgView.hidden = YES;
            
            self.datasourceList = [response lastObject];
            
            self.imagesList = [[NSMutableArray alloc] initWithArray:[[[response lastObject]valueForKey:@"img_url"] allValues]];
            
            [self.imgScrollerTableView reloadData];
        }
        else
        {
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
            [message addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"comfortaa" size:15]
                            range:NSMakeRange(0, message.length)];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:message forKey:@"attributedTitle"];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failureBlock:^(id response, NSError *error) {
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






-(IBAction)match:(id)sender
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid1": @"8",
                   @"userid2": @"6"
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

                 self.matchBtn.hidden = YES;
                 self.passBtn.hidden = YES;
//                 self.noProfileImgView.hidden = NO;
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

-(IBAction)pass:(id)sender
{
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"You have passed the profile!"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            self.matchBtn.hidden = YES;
            self.passBtn.hidden = YES;
//            self.noProfileImgView.hidden = NO;
        }];
        
        action;
    })];
    
    [self presentViewController:alertController  animated:YES completion:nil];
    
}

@end
