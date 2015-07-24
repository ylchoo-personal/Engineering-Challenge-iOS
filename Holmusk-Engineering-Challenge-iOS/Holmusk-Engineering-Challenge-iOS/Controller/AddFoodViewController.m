//
//  AddFoodViewController.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "AddFoodViewController.h"
#import "AppSharedInstance.h"
#import "SVProgressHUD.h"
#import "Food.h"
#import "UIViewController+MJPopupViewController.h"

@interface AddFoodViewController ()

@end

@implementation AddFoodViewController

#pragma mark - IBAction
-(IBAction)searhTapped:(id)sender{
    //validate food search
    if ([_searchTextField.text isEmptyString]) {
        [SVProgressHUD showErrorWithStatus:@"Please enter food name" maskType:SVProgressHUDMaskTypeGradient];
    }
    else{
        //load food data from server
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
        foundFoodArray = [[AppSharedInstance sharedInstance] getFoodInfo:_searchTextField.text];
        
        if (foundFoodArray) {
            _sizeManager = [[RZCellSizeManager alloc] init];
            [_sizeManager registerCellClassName:NSStringFromClass([FoodDetailTableViewCell class])
                                   withNibNamed:@"FoodDetailTableViewCell"
                                 forObjectClass:[Portion class]
                         withConfigurationBlock:^(FoodDetailTableViewCell *cell, Portion *object) {
                             [cell setCellData:object];
                         }];
            [SVProgressHUD dismiss];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"Error" maskType:SVProgressHUDMaskTypeGradient];
        }
        
        [_myTableView reloadData];
    }
}

#pragma mark - TextField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _myTableView.hidden = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _myTableView.hidden = NO;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searhTapped:nil];
    return NO;
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Enter Food";
    
    //autocomplete textfield setup
    [_searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [_searchTextField setAutoCompleteTableAppearsAsKeyboardAccessory:NO];
    _searchTextField.maximumNumberOfAutoCompleteRows = 10;
    _searchTextField.autoCompleteRowHeight = 25;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return foundFoodArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Food *food = [foundFoodArray objectAtIndex:section];
    return food.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    Food *food = [foundFoodArray objectAtIndex:section];
    return food.portions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Food *food = foundFoodArray[indexPath.section];
    Portion *portion = food.portions[indexPath.row];
    CGFloat height= [self.sizeManager cellHeightForObject:portion indexPath:indexPath cellReuseIdentifier:@"FoodDetailTableViewCell"];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FoodDetailTableViewCell";
    FoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *cellTeam = [[NSBundle mainBundle] loadNibNamed:@"FoodDetailTableViewCell" owner:self options:nil];
        cell = [cellTeam objectAtIndex:0];
        cell.cellDelegate = self;
    }
    
    // Configure the cell...
    Food *food = [foundFoodArray objectAtIndex:indexPath.section];
    [cell setCellData:food.portions[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Food *food = foundFoodArray[indexPath.section];
    Portion *portion = food.portions[indexPath.row];
    portion.isSelected = !portion.isSelected;
    [_sizeManager invalidateCellSizeAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Custom UITableViewCell delegate
-(void)enterFoodTapped:(FoodDetailTableViewCell *)sender{
    //show enteramountVC when enter button on fooddetailcell tapped
    NSIndexPath *indexPath = [_myTableView indexPathForCell:sender];
    Food *food = foundFoodArray[indexPath.section];
    Portion *portion = food.portions[indexPath.row];
    EnterAmountViewController *vc = [[EnterAmountViewController alloc] initWithNibName:nil bundle:nil];
    vc.enterAmountDelegate = self;
    UserData *userData = [[UserData alloc] init];
    userData.food = food;
    userData.selectedPortion = portion;
    vc.userData = userData;
    [vc.view setFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.7, self.view.frame.size.width * 0.7)];
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - MLPAutoCompleteTextField Delegate
- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedObject){
        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
    } else {
        NSLog(@"selected string '%@' from autocomplete menu", selectedString);
        _searchTextField.text = selectedString;
        [self searhTapped:nil];
    }
}

#pragma mark - MLPAutoCompleteTextField DataSource
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    //food data from realm and filter for autocomplete use
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        RLMResults *foods = [Food allObjects];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",
                            textField.text];
        foods = [foods objectsWithPredicate:pred];
        handler([foods valueForKey:@"name"]);
    });
}

#pragma mark - EnterAmountDelegate
-(void)dismissEnterAmountViewControllerPopup{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

@end
