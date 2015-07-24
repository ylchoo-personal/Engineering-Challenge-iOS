//
//  MainViewController.m
//  Holmusk-Engineering-Challenge-iOS
//
//  Created by Yew Liang Choo on 16/7/15.
//  Copyright (c) 2015 Yew Liang Choo. All rights reserved.
//

#import "MainViewController.h"
#import "DataPlot.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create a gradient to apply to the bottom portion of the graph
    self.title = @"Holmusk iOS Challenge";
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    _myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    // Enable and disable various graph properties and axis displays
    _myGraph.enableTouchReport = YES;
    _myGraph.enablePopUpReport = YES;
    _myGraph.enableYAxisLabel = YES;
    _myGraph.autoScaleYAxis = YES;
    _myGraph.alwaysDisplayDots = YES;
    _myGraph.enableReferenceXAxisLines = YES;
    _myGraph.enableReferenceYAxisLines = YES;
    _myGraph.enableReferenceAxisFrame = YES;
    
    // Draw an average line
    _myGraph.averageLine.enableAverageLine = YES;
    _myGraph.averageLine.alpha = 0.6;
    _myGraph.averageLine.color = [UIColor darkGrayColor];
    _myGraph.averageLine.width = 2.5;
    _myGraph.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    _myGraph.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    _myGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    _myGraph.formatStringForValues = @"%.1f";
}

-(void)viewWillAppear:(BOOL)animated{
    //get new data set
    RLMResults *result = [UserData allObjects];
    
    _dataArray = [NSMutableArray new];
    if (result.count > 0) {
        if (!selectedNutrientDetail) {
            UserData *userData = [result objectAtIndex:0];
            
            if (userData.selectedPortion.nutrients.important.count > 0) {
                selectedNutrientDetail = [userData.selectedPortion.nutrients.important objectAtIndex:0];
            }
            else if (userData.selectedPortion.nutrients.extra.count > 0) {
                selectedNutrientDetail = [userData.selectedPortion.nutrients.extra objectAtIndex:0];
            }
        }
        
        result = [result sortedResultsUsingProperty:@"datetime" ascending:YES];
        
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"d MMM yy"];
        }
        
        UserData *userData = [result objectAtIndex:0];
        DataPlot *dataPlot = [[DataPlot alloc] initWithXValue:[userData getDateString]];

        for (UserData *userData in result) {
            NutrientDetail *nutrientDetail = [userData.selectedPortion getNutrientDetailForNutrient:selectedNutrientDetail.name];
            
            if ([[dateFormatter stringFromDate:userData.datetime] isEqualToString:dataPlot.xValue]) {
                dataPlot.yValue += userData.value * nutrientDetail.value;
            }
            else{
                [_dataArray addObject:dataPlot];
                
                //mark down date to use loop to fill in empty gap date
                NSDate *thisDate = [dateFormatter dateFromString:dataPlot.xValue];
                thisDate = [thisDate dateByAddingTimeInterval:24*60*60];
                
                dataPlot = [[DataPlot alloc] initWithXValue:[userData getDateString]];
                while (![[dateFormatter stringFromDate:thisDate] isEqualToString:dataPlot.xValue]) {
                    //add dummy dataplot for empty day
                    DataPlot *emptyDataPlot = [[DataPlot alloc] initWithXValue:[dateFormatter stringFromDate:thisDate]];
                    [_dataArray addObject:emptyDataPlot];
                    thisDate = [thisDate dateByAddingTimeInterval:24*60*60];
                }
                dataPlot = [[DataPlot alloc] initWithXValue:[userData getDateString]];
                dataPlot.yValue += userData.value * nutrientDetail.value;
            }
        }
        //add last dataplot if it is not added
        if (![[_dataArray lastObject] isEqual:dataPlot]) {
            [_dataArray addObject:dataPlot];
        }
        //add dummy data so graph got at least 2 data to draw graph
        if (_dataArray.count == 1) {
            DataPlot *temp = [[DataPlot alloc] initWithXValue:[dateFormatter stringFromDate:[userData.datetime dateByAddingTimeInterval:-24*60*60]]];
            [_dataArray insertObject:temp atIndex:0];
        }
        
        _unitLabel.text = selectedNutrientDetail.unit;
        _myGraph.hidden = NO;
    }
    else{
        _unitLabel.text = @"";
        _myGraph.hidden = YES;
    }
    
    [_myGraph reloadGraph];
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

#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return _dataArray.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    DataPlot *dataPlot = _dataArray[index];
    return dataPlot.yValue;
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
//    NSString *label = [self labelForDateAtIndex:index];
//    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    DataPlot *dataPlot = _dataArray[index];
    return [dataPlot.xValue substringToIndex:[dataPlot.xValue length] - 3];
}

@end
