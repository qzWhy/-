//
//  MPAlertView.h
//  SDJingjiRadio_Swift
//
//  Created by zghsnail on 14/11/13.
//  Copyright (c) 2014年 jusa. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,NetAndTitleState){
    NO_Network, //无网络
    OUT_Newwork //网络连接超时
};

@interface MPAlertView : UIView
+ (void)show:(NSString *)title;
+ (void)showBeforeKeyboard:(NSString*)title;

+ (void)show:(NSString*)title withOffsetX:(CGFloat)dx withOffsetY:(CGFloat)dy;

+ (void)showTitle:(NSString*)title withView:(UIView*)view;

+(void)showDefaultTitle:(NetAndTitleState)state;

//+(void)changeShowTitle;
@end

