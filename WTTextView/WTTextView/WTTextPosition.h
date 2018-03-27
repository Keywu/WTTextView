//
//  WTTextPosition.h
//  WTTextView
//
//  Created by yandere on 2018/3/27.
//  Copyright © 2018年 org.objc.yandere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTextPosition : UITextPosition

@property (nonatomic, assign) NSInteger index;

+ (instancetype)textPositionWithIndex:(NSInteger)index;

@end
