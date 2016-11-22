//
//  XYTitleView.m
//  XYSegementView
//
//  Created by 向阳 on 16/11/22.
//  Copyright © 2016年 xiangyang. All rights reserved.
//

#import "XYTitleView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define margin 10

@interface XYTitleView ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *titleBtnArray;
@property (nonatomic, strong) UIView  *indicateLine;
@property (nonatomic, strong) UIView  *lineView;

@property (nonatomic, assign) CGFloat height;

@end

@implementation XYTitleView

-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = titleArray;
        _titleBtnArray = [NSMutableArray array];
        self.height = frame.size.height;
        
        CGFloat btnWidth = kScreenWidth/titleArray.count;
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, self.height)];
            [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.tag = i;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:btn];
            [_titleBtnArray addObject:btn];
        }
        
        _indicateLine = [[UIView alloc] initWithFrame:CGRectMake(margin, self.height-2, btnWidth-margin*2, 2)];
        _indicateLine.backgroundColor = [UIColor redColor];
        [self addSubview:_indicateLine];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, self.frame.size.width, 0.5)];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.850 alpha:1.000];
        [self addSubview:_lineView];
    }
    return self;
}

-(void)clickBtn : (UIButton *)btn{
    
    NSInteger tag = btn.tag;
    [self itemSelected:tag];
    
    if (self.titleClickBlock) {
        self.titleClickBlock(tag);
    }
}

-(void)itemSelected: (NSInteger)column{
    for (int i=0; i<_titleBtnArray.count; i++) {
        UIButton *btn = _titleBtnArray[i];
        if (i==column) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    CGFloat btnWidth = kScreenWidth/_titleBtnArray.count;
    
    [UIView animateWithDuration:0.2 animations:^{
        _indicateLine.frame = CGRectMake(btnWidth*column+margin, self.height-2, btnWidth-margin*2, 2);
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
