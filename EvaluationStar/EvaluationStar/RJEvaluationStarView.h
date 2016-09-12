//
//  EvaluationStarView.h
//  EvaluationStar
//
//  Created by chenli on 16/8/18.
//  Copyright © 2016年 Lyc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EvaluationStarViewMode) {
    EvaluationStarViewFullStar = 0, //整星模式
    EvaluationStarViewHalfStar, //半星模式
    EvaluationStarViewAnyStar, //默认，任意模式(一颗星可取值：0.0～1.0)
};

@interface RJEvaluationStarView : UIView
@property (assign, nonatomic) CGFloat evaluationValue;
@property (copy, nonatomic) void(^selectedBlock)(CGFloat value);
@property (assign, nonatomic) NSInteger sumStars;
@property (copy, nonatomic) NSString *starNormalImg;
@property (copy, nonatomic) NSString *starHighlightImg;
@property (assign, nonatomic) EvaluationStarViewMode evaluationMode;

+ (instancetype)evaluationStarViewMode:(EvaluationStarViewMode)evaluationMode frame:(CGRect)frame selectedBlock:(void(^)(CGFloat value))selectedBlock;

/**
 *  基本属性设置
 *
 *  @param sumStars         星星数量(默认为5颗)
 *  @param starNormalImg    未选中星星
 *  @param starHighlightImg 选中星星
 */
- (void)setSumStars:(NSInteger)sumStars starNormalImg:(NSString *)starNormalImg starHighlightImg:(NSString *)starHighlightImg;

@end
