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
@interface BUHomeViewController ()
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;
@property(nonatomic, strong) NSArray *datasourceList;
@end

@implementation BUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.imagesList = [NSMutableArray arrayWithObjects:@"1",@"5",@"4",@"3",@"2", nil];
    self.datasourceList =    @[@{@"Name":@"Private until connected"},
                               @{@"Age":@"22"},
                               @{@"Location":@"Bangalore, KA"},
                               @{@"Height":@"5’"},
                               @{@"Religion":@"Hindu"},
                               @{@"Mother Tongue":@"Kannada"},
                               @{@"Specification":@"Lorem lpsum"},
                               @{@"Family Origin":@"Gowda"}];
    // Do any additional setup after loading the view.
    

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Table view size frame: %@",NSStringFromCGRect(self.imgScrollerTableView.bounds));

    [self.imgScrollerTableView reloadData];
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
        cell.matchTitleLabel.text = [[[self.datasourceList objectAtIndex:indexPath.row] allKeys] firstObject];

        cell.matchDescritionLabel.text = [[[self.datasourceList objectAtIndex:indexPath.row] allValues]firstObject];

        return cell;
    }
    return nil;
}

@end
