//
//  EvaluationStarView.m
//  EvaluationStar
//
//  Created by chenli on 16/8/18.
//  Copyright © 2016年 Lyc. All rights reserved.
//

#import "RJEvaluationStarView.h"

#define kStarImage_width 30
@interface RJEvaluationStarView () {
    UIView *_bottomView;
    UIView *_maskView;
    CGRect _maskRect;
}

@end

@implementation RJEvaluationStarView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self createStarsView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initData];
        [self createStarsView];
    }
    return self;
}


+ (instancetype)evaluationStarViewMode:(EvaluationStarViewMode)evaluationMode frame:(CGRect)frame selectedBlock:(void (^)(CGFloat))selectedBlock {
    RJEvaluationStarView *starView = [[self alloc] initWithFrame:frame];
    starView.evaluationMode = evaluationMode;
    starView.selectedBlock = selectedBlock;
    return starView;
}


- (void)initData {
    _sumStars = 5;
    _evaluationValue = 0;
    _maskRect = self.bounds;
    _evaluationMode = EvaluationStarViewAnyStar;
    _starNormalImg = @"star_n";
    _starHighlightImg = @"star_h";
}

- (void)createStarsView {
    _bottomView = [[UIView alloc] init];
    _maskView = [[UIView alloc] init];
    _maskView.clipsToBounds = YES;
    _maskView.hidden = !_evaluationValue;
    [self createStarsView:5];
    [self addSubview:_bottomView];
    [self addSubview:_maskView];
}


- (void)createStarsView:(NSInteger)sum {
    for (NSInteger i = 0; i < sum; i++) {
        UIImageView *imgNV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_starNormalImg]];
        UIImageView *imgHV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_starHighlightImg]];
        [_bottomView addSubview:imgNV];
        [_maskView addSubview:imgHV];
    }
}


- (void)setSumStars:(NSInteger)sumStars starNormalImg:(NSString *)starNormalImg starHighlightImg:(NSString *)starHighlightImg {
    self.sumStars = sumStars;
    self.starNormalImg = starNormalImg;
    self.starHighlightImg = starHighlightImg;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutSubview:_bottomView frame:self.bounds];
    [self layoutSubview:_maskView frame:_maskRect];
}

- (void)layoutSubview:(UIView *)subView frame:(CGRect)frame {
    subView.frame = frame;
    CGFloat margin = (self.bounds.size.width - kStarImage_width * _sumStars)/_sumStars;
    for (NSInteger i = 0; i < subView.subviews.count; i++) {
        UIImageView *imgV = subView.subviews[i];
        CGFloat x = i* (kStarImage_width + margin);
        CGFloat y = (self.bounds.size.height - kStarImage_width)*0.5;
        imgV.frame = CGRectMake(x, y, kStarImage_width, kStarImage_width);
    }
}


#pragma mark - 选择事件回调
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat touchX = [[touches anyObject] locationInView:self].x;
    CGFloat margin = (self.bounds.size.width - kStarImage_width * _sumStars)/_sumStars;
    CGFloat w = margin + kStarImage_width;
    CGFloat value = touchX/w;
    switch (_evaluationMode) {
        case EvaluationStarViewFullStar:
            touchX = ceilf(value) * w;
            value = ceilf(value);
            break;
        case EvaluationStarViewHalfStar:
            if (roundf(value) < floorf(value) + 0.5) {
                value = floorf(value) + 0.5;
                touchX = floorf(value) * (margin + kStarImage_width) + 0.5 * kStarImage_width;
            } else {
                touchX = ceilf(value) * w;
                value = ceilf(value);
            }
            
            break;
        case EvaluationStarViewAnyStar:
            
            break;
        default:
            break;
    }
    
    _maskView.hidden = NO;
    _maskRect = CGRectMake(0, 0, touchX, self.bounds.size.height);
    _maskView.frame = _maskRect;
    if (self.selectedBlock) {
        self.selectedBlock(value);
    }
}

#pragma mark - private setter method
- (void)setSumStars:(NSInteger)sumStars {
    if (_sumStars != sumStars) {
        for (UIImageView *imgV in _bottomView.subviews) {
            [imgV removeFromSuperview];
        }
        for (UIImageView *imgV in _maskView.subviews) {
            [imgV removeFromSuperview];
        }
        [self createStarsView:sumStars];
    }
    _sumStars = sumStars;
}

- (void)setStarNormalImg:(NSString *)starNormalImg {
    if (!starNormalImg && !starNormalImg.length) return;
    if (![_starNormalImg isEqualToString:starNormalImg]) {
        for (UIImageView *imgV in _bottomView.subviews) {
            imgV.image = [UIImage imageNamed:starNormalImg];
        }
    }
    _starNormalImg = starNormalImg;
}

- (void)setStarHighlightImg:(NSString *)starHighlightImg {
    if (!starHighlightImg && !starHighlightImg.length) return;
    if (![_starHighlightImg isEqualToString:starHighlightImg]) {
        for (UIImageView *imgV in _maskView.subviews) {
            imgV.image = [UIImage imageNamed:starHighlightImg];
        }
    }
    _starHighlightImg = starHighlightImg;
}

@end
