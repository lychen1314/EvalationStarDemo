//
//  ViewController.m
//  EvaluationStar
//
//  Created by chenli on 16/8/18.
//  Copyright © 2016年 Lyc. All rights reserved.
//

#import "ViewController.h"
#import "RJEvaluationStarView.h"

@interface ViewController ()
@property (strong, nonatomic) UILabel *lb;
@property (weak, nonatomic) IBOutlet RJEvaluationStarView *starView2;
@property (weak, nonatomic) IBOutlet RJEvaluationStarView *starView3;
@property (strong, nonatomic) RJEvaluationStarView *starView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 60, 40)];
    _lb.text = @"半星：";
    
    CGRect rect = CGRectMake(70, 110, 180, 40);
    _starView = [RJEvaluationStarView evaluationStarViewMode:EvaluationStarViewHalfStar frame:rect selectedBlock:^(CGFloat value) {
        NSLog(@"value1:%.1f",value);
    }];
    [self.view addSubview:_lb];
    [self.view addSubview:_starView];
    
    _starView2.sumStars = 8;
    _starView2.evaluationMode = EvaluationStarViewFullStar;
    _starView2.starHighlightImg = @"star_h";
    _starView2.selectedBlock = ^(CGFloat value){
        NSLog(@"value2:%.1f",value);
    };
    
    [_starView3 setSumStars:6 starNormalImg:nil starHighlightImg:@"star_h"];
    _starView3.selectedBlock = ^(CGFloat value){
        NSLog(@"value3:%.1f",value);
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
