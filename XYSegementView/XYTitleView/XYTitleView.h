//
//  XYTitleView.h
//  XYSegementView
//
//  Created by 向阳 on 16/11/22.
//  Copyright © 2016年 xiangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XYTitleViewClickBlock)(NSInteger);

@interface XYTitleView : UIView

-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray;

@property (nonatomic, strong) XYTitleViewClickBlock titleClickBlock;

-(void)itemSelected:(NSInteger)column;

@end
