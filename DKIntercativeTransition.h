//
//  DKIntercativeTransition.h
//  TransitionsDemo
//
//  Created by 黄达凯 on 2018/11/5.
//  Copyright © 2018年 黄达凯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GestureConfig)(void);

typedef NS_ENUM(NSUInteger, DKInteractiveTransitionGestureDirection) { //手势的方向
    DKInteractiveTransitionGestureDirectionLeft = 0,
    DKInteractiveTransitionGestureDirectionRight,
    DKInteractiveTransitionGestureDirectionUp,
    DKInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, DKInteractiveTransitionType) { // 手势控制哪种转场
    DKInteractiveTransitionTypePresent = 0,
    DKInteractiveTransitionTypeDissmiss,
    DKInteractiveTransitionTypePush,
    DKInteractiveTransitionTypePop
};

@interface DKIntercativeTransition : UIPercentDrivenInteractiveTransition

// 记录是否开始手势，判断pop操作是手势触发还是返回键触发
@property (nonatomic,assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConfig presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConfig pushConifg;

+ (instancetype)interactiveTransitionWithTransitionType:(DKInteractiveTransitionType)type GestureDirection:(DKInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionWithTransitionType:(DKInteractiveTransitionType)type GestureDirection:(DKInteractiveTransitionGestureDirection)direction;

// 给传入的控制器添加手势
- (void)addPanGestureForViewController:(UIViewController *)viewContrller;

@end

NS_ASSUME_NONNULL_END
