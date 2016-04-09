//
//  ViewController.m
//  PikerViewOptionBox
//
//  Created by hadis on 16/4/9.
//  Copyright © 2016年 marc. All rights reserved.
//

#import "ViewController.h"
#import "MCPikerView.h"
@interface ViewController ()
- (IBAction)clickWithButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)clickWithButton:(id)sender {
    NSArray *ary = @[@"123",@"123",@"123"];
    
    [MCPikerView showWithItemsBlock:^(id<MCClickedItmesProtocol> items) {
        [items addItemsWithPikerView:ary];
    } clickedBlock:^(NSInteger clickedIndex) {
        NSLog(@"选中第%d数据源",clickedIndex);
    }];
}
@end
