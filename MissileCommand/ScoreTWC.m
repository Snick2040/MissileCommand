//
//  ScoreTWC.m
//  MissileCommand
//
//  Created by Nick on 10/29/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import "ScoreTWC.h"


@interface ScoreTWC ()

@end

@implementation ScoreTWC{
    
    //NSNumber * newScore;
    NSMutableArray * recentScores;
    NSArray * sortedScores;
}

@synthesize newScore = _newScore;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setNewScore:(int)newScore
{
    _newScore = newScore;
    
    //NSLog(@"Score %d", self.newScore);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    recentScores = [[defaults objectForKey:@"SCORE"] mutableCopy];
    if (!recentScores) recentScores = [NSMutableArray array];
    
    [recentScores insertObject:[NSNumber numberWithInt: self.newScore] atIndex:0];
    NSLog(@"Score %d, count: %lu", self.newScore, (unsigned long)[recentScores count]);
    if (recentScores.count > 50) [recentScores removeLastObject];
    
    NSSortDescriptor * sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    sortedScores = [recentScores sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    //sortedScores = [recentScores sortedArrayUsingSelector:@selector(compare:)];
    
    [defaults setObject:recentScores forKey:@"SCORE"];
    [defaults synchronize];
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [recentScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Score";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *score = [NSString stringWithFormat:@"%@",[sortedScores objectAtIndex: indexPath.row]];
    cell.textLabel.text = score;
    //NSLog(@"cell.");
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
