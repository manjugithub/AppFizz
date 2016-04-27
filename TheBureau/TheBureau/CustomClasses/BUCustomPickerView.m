//
//  BUCustomPickerView.m
//  TheBureau
//
//  Created by Manjunath on 25/04/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUCustomPickerView.h"
#import "PWCustomPickerCell.h"

@implementation BUCustomPickerView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */




- (IBAction)closePickerView:(id)sender
{
    [self.view removeFromSuperview];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view removeFromSuperview];
}

-(void)showCusptomPickeWithDelegate:(id<PWPickerViewDelegate>) inDelegate
{
    self.delegate = inDelegate;
    UIWindow *window  =  [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
    [self.pickerTableView reloadData];
    
    self.pickerOverLay.layer.cornerRadius = 5.0;
}

#pragma mark - TableView delegate and datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.pickerDataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"mediaIdentifier";
    PWCustomPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [PWCustomPickerCell createPWCustomPickerCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        
    }
    PWHeritageObj *inDataSourceDict = [self.pickerDataSource objectAtIndex:indexPath.row];
    cell.titleLabel.text = inDataSourceDict.name;
    [cell selectDatasource:inDataSourceDict.isSelected];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        [self.delegate didItemSelected:[self.pickerDataSource objectAtIndex:indexPath.row]];
        
        PWHeritageObj *obj = [self.pickerDataSource objectAtIndex:indexPath.row];
    
        if(NO == [obj isSelected])
        {
            obj.isSelected = YES;
            [self.delegate didItemSelected:obj];
        }
        else
        {
            obj.isSelected = NO;
            [self.delegate didItemDeselectedSelected:obj];
        }
        
        [tableView reloadData];
}

-(void)resetDataSource
{
    for (NSMutableDictionary *dict in self.pickerDataSource)
    {
        [dict setValue:[NSNumber numberWithBool:NO] forKey:@"state"];
    }
}


@end
