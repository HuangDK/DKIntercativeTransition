//
//  DKIntercativeTransition.m
//  TransitionsDemo
//
//  Created by 黄达凯 on 2018/11/5.
//  Copyright © 2018年 黄达凯. All rights reserved.
//

#import "DKIntercativeTransition.h"

@interface DKIntercativeTransition()

@property (nonatomic,weak) UIViewController *vc;
// 手势方向
@property (nonatomic, assign) DKInteractiveTransitionGestureDirection direction;
// 手势类型
@property (nonatomic, assign) DKInteractiveTransitionType type;

@end

@implementation DKIntercativeTransition

+ (instancetype) interactiveTransitionWithTransitionType:(DKInteractiveTransitionType)type GestureDirection:(DKInteractiveTransitionGestureDirection)direction {
    return [[self alloc] initWithTransitionWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionWithTransitionType:(DKInteractiveTransitionType)type GestureDirection:(DKInteractiveTransitionGestureDirection)direction {
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewContrller {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewContrller;
    [viewContrller.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan {
    // 手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case DKInteractiveTransitionGestureDirectionLeft: {
            // locationInView:获取到的是手指点击屏幕实时的坐标点；
            // translationInView：获取到的是手指移动后，在相对坐标中的偏移量
            CGFloat transitionX = -[pan translationInView:pan.view].x;
            persent = transitionX / pan.view.frame.size.width;
        }
            break;
        case DKInteractiveTransitionGestureDirectionRight: {
            CGFloat transitionX = [pan translationInView:pan.view].x;
            persent = transitionX / pan.view.frame.size.width;
        }
            break;
        case DKInteractiveTransitionGestureDirectionUp: {
            CGFloat transitionY = -[pan translationInView:pan.view].y;
            persent = transitionY / pan.view.frame.size.width;
        }
            break;
        case DKInteractiveTransitionGestureDirectionDown: {
            CGFloat transitionY = [pan translationInView:pan.view].y;
            persent = transitionY / pan.view.frame.size.width;
        }
            break;
            
        default:
            break;
    }
    NSLog(@"%.2f", persent);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            // 手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:
            // 手势过程中，通过 updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        case UIGestureRecognizerStateEnded:
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
            
        default:
            break;
    }
}

- (void)startGesture {
    switch (_type) {
        case DKInteractiveTransitionTypePresent: {
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
        case DKInteractiveTransitionTypeDissmiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case DKInteractiveTransitionTypePush: {
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case DKInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

@end
