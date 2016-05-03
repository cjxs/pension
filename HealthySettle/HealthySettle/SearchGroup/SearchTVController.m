//
//  SearchTVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/24.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchTVController.h"
#import "SearchOrganTVCell.h"
@interface SearchTVController ()
{
    NSArray * data_array;
}

@end

@implementation SearchTVController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"发现 • 热门机构";
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchOrganTVCell" bundle:nil]
         forCellReuseIdentifier:@"cellSearch"];
    data_array = @[[UIImage imageNamed:@"search_01"],[UIImage imageNamed:@"search_02"],[UIImage imageNamed:@"search_01"],[UIImage imageNamed:@"search_01"],[UIImage imageNamed:@"search_02"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchOrganTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellSearch"
                                                               forIndexPath:indexPath];
    [cell configWithImage:data_array[indexPath.section]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return screenHeight * 0.33;
}
-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
