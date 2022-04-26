//
//  MPAlertView.m
//  SDJingjiRadio_Swift
//
//  Created by zghsnail on 14/11/13.
//  Copyright (c) 2014年 jusa. All rights reserved.
//

#import "MPAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "SystemUtils.h"
#import "Reachability.h"

//#import <objc/runtime.h>
@interface MPAlertView (Private)
//初始化
- (id)initWithTitle:(NSString*)title;

//设置圆角半径
- (void)setRadius:(CGFloat)radius;
//旋转
- (void)rotate;
//显示
- (void)show;
//隐藏
- (void)hide;

@end


#define left 10
#define top 20
#define width 200

#define kMPAlertViewTag            31014


@implementation MPAlertView

- (id)initWithTitle:(NSString*)title
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
        UIFont* font = [UIFont fontWithName:@"Arial" size:16];
        
        //设置一个行高上限
        CGSize size = CGSizeMake(width,2000);
        
        // 根据文字长度计算
        CGRect rect = [title boundingRectWithSize:size
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName :font}
                                          context:nil];
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = rect.size;
        
        //创建新的label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor lightTextColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setNumberOfLines:0];
        [label setText:title];
        [label setFont:font];
        [label setFrame:CGRectMake(left, top, width, labelsize.height)];
        //设置自动行数与字符换行
        [label setNumberOfLines:0];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        CGFloat h = ([SystemUtils screenHeight] - labelsize.height - top*2) / 2;
        CGFloat w = ([SystemUtils screenWidth] - left*2 - width) / 2;
        [self setFrame:CGRectMake(w, h, width+left*2,labelsize.height+top*2)];
        [self addSubview:label];
        
    }
    return self;
}

//公共接口，显示框
+ (void)show:(NSString*)title
{
    //无网络提示信息
    BOOL re = [[NSUserDefaults standardUserDefaults] boolForKey:@"ZSTNetWorkStatus"];
    if (!re){
        [self showDefaultTitle:NO_Network];
        return ;
    }
    
    //弱网提示信息
    if ([title containsString:@"网络连接失败"] || [title containsString:@"网络请求失败"]){
        [self showDefaultTitle:OUT_Newwork];
            return ;
    }
    

    MPAlertView* view = [[MPAlertView alloc] initWithTitle:title];
    [view setRadius:6];
    [view rotate];
    [view show];
    
}

+(BOOL)getNetState{
    Reachability *hostreac = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [hostreac currentReachabilityStatus];
    if (status == NotReachable){
        return YES;
    }
    return NO;
}
+(void)showDefaultTitle:(NetAndTitleState)state{
    NSString *title = @"网络不给力，请检查网络连接后重试";
    if (state == OUT_Newwork){
        title = @"连接超时";
    }
    MPAlertView* view = [[MPAlertView alloc] initWithTitle:title];
    [view setRadius:6];
    [view rotate];
    [view show];
}

+ (void)showBeforeKeyboard:(NSString*)title
{
    
    MPAlertView* view = [[MPAlertView alloc] initWithTitle:title];
    
    CGRect frame = view.frame;
    frame.origin.y  -= 60;
    
    [view setFrame:frame];
    [view setRadius:6];
    [view rotate];
    [view show];
}


+ (void)show:(NSString*)title withOffsetX:(CGFloat)dx withOffsetY:(CGFloat)dy
{
    MPAlertView* view = [[MPAlertView alloc] initWithTitle:title];
    [view setRadius:6];
    [view rotate];
    [view show];
    
    [view setFrame:CGRectOffset(view.frame, dx, dy)];
}

// 横屏专用
+ (void)showTitle:(NSString*)title withView:(UIView*)view
{
    MPAlertView* v = [[MPAlertView alloc] initWithTitle:title];
    [v setRadius:6];
    [v setCenter:CGPointMake([SystemUtils screenHeight]/2, [SystemUtils screenWidth]/2)];
    [v setAlpha:0.0];
    [v setTag:kMPAlertViewTag];
    
    NSLog(@"v1:%@vv:%@",NSStringFromCGRect(view.frame),NSStringFromCGRect(v.frame));
    
    //获取上一次的弹出框
    UIView* last = [view viewWithTag:kMPAlertViewTag];
    
    [view addSubview:v];
    
    [UIView animateWithDuration:0.0 animations:
     ^{
         v.alpha = 1.0f;
     } completion:
     ^(BOOL finished)
     {
         //移除上一次的弹出框
         if ([last respondsToSelector:@selector(removeFromSuperview)]) {
             [last removeFromSuperview];
         }
         [v performSelector:@selector(hide) withObject:self afterDelay:3];
     }];
}

- (void)setRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
    [self setOpaque:NO];
}

- (void)rotate
{
    UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat r = 0.0;
    switch (orient) {
        case UIInterfaceOrientationPortrait: r= 0.0; break;
        case UIInterfaceOrientationLandscapeRight:r= M_PI_2; break;
        case UIInterfaceOrientationPortraitUpsideDown:r= M_PI_4; break;
        case UIInterfaceOrientationLandscapeLeft:r= M_PI_2*3; break;
        default:r=0.0;break;
    }
    
    [self setTransform:CGAffineTransformRotate(CGAffineTransformIdentity, r)];
}

- (void)show
{
    [self setAlpha:0.0];
    [self setTag:kMPAlertViewTag];
    
    //获取window
    UIWindow* window = SystemUtils.setupKeyWindow;
    //获取上一次的弹出框
    UIView* last = [window viewWithTag:kMPAlertViewTag];
    
    //把当前弹出层展示出来
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    
    //展示动画
    [UIView animateWithDuration:0.0 animations:
     ^{
         self.alpha = 2.0f;
     } completion:
     ^(BOOL finished)
     {
         //移除上一次的弹出框
         if ([last respondsToSelector:@selector(removeFromSuperview)]) {
             [last removeFromSuperview];
         }
         [self performSelector:@selector(hide) withObject:self afterDelay:1.5];
     }];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
}

- (void)hide
{
    [UIView animateWithDuration:0.8 animations:
     ^{
         self.alpha = 0.0f;
     } completion:
     ^(BOOL finished)
     {
         [self removeFromSuperview];
     }];
}

@end
