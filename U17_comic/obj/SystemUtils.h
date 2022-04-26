//
//  SystemUtils.h
//  Test
//
//  Created by jusa on 16/5/30.
//  Copyright © 2016年 jusa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "Config.h"

@interface SystemUtils : NSObject

// 获取屏幕宽度
// 以static的方式获取，避免重复计算
+ (CGFloat)screenWidth;

// 屏幕高度
// 以static的方式获取，避免重复计算
+ (CGFloat)screenHeight;

+ (BOOL)getOCIsIphoneX;

+ (CGFloat)zSafeArea_Bottom;

// 获取颜色
+ (UIColor*)RGBA:(int)r g:(int)g b:(int)b alpha:(float)a;

// 获取颜色
+ (UIColor*)RGB:(int)r g:(int)g b:(int)b;

+ (BOOL)isLigleCharacters:(NSString *)nama;

//+ (NSString*)getSizeCach;

+ (BOOL) isEmailAddress: (NSString *) candidate;

+ (BOOL)isgoodpwd:(NSString*)ninput;

+ (NSString*)followersCount:(NSString*)num;

+(BOOL)iscarpad:(NSString*)input;
/*
 * 描述：计算字符串绘制在屏幕上的宽度
 * 参数：要绘制的字符串
 * 参数：字体
 * 返回值：绘制的高度
 */
+ (CGFloat)widthForString:(NSString*)aString
                 withFont:(UIFont*)font;

+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

//
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
/*
 * 描述：字符串转换为日期格式
 * 参数：时间
 * 返回值：2012-12-11 10:00:00
 */
+ (NSDate*)getTime:(NSString*) playTime;
/*
 * 描述：根据日期生成显示的字符串
 * 参数：时间
 * 返回值：
 */
+ (NSString*)stringByTime:(NSDate*)time;

+ (NSString*)nowTime;

//
+ (UIImage*)getPreViewImg:(NSURL*)url;
//数字转中文
+(NSString *)digitUppercase:(NSString *)money;
/*
 * 描述：判断字符串里是否包含表情
 * 参数：字符串
 * 返回值：
 */
+(BOOL)isContainsEmoji:(NSString *)string;

/*
 * 描述：生成GUID
 * 参数：无
 * 返回值：无
 */
+ (NSString*)createGUID;

/*
 * 描述：压缩图片
 * 返回值：无
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)image;

//截取图片
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

//将UIView转成UIImage,将UIImage转成PNG/JPG//
+(UIImage *)getImageFromView:(UIView *)view;

// 计算文件的md5
+ (NSString*)MD5forFile:(NSString*)url;

// 获取文件的大小
+ (NSInteger)getFileSize:(NSString*)path;


+ (BOOL)validateNumber:(NSString*)number;
//只能输入数字和字母
+ (BOOL)isNumberAndCharecter:(NSString*)input;
+ (NSString *) md5:(NSString *)str;
//密码验证
+(BOOL)isPassword:(NSString*)input;
//只能输入数字
+ (BOOL)isNumber:(NSString*)input;

//只能输入数字
+ (BOOL)isIntNumber:(NSString*)input;

//只能输入整数且保留两位小数
+ (BOOL)isNumberAndTwoNumber:(NSString*)input;
//只能输入整数且保留三位小数
+ (BOOL)isNumberAndThreeNumber:(NSString*)input;

//手机号码
+ (BOOL)isPhonenumber:(NSString*)number;
+ (BOOL)checkPassword:(NSString *) password;
// 判断中英文混合字符的长度
+ (NSInteger)judgeChineseAndChacterLength:(NSString *)text;
//验证品牌 只能是字母数字和汉子 中间可以有空格
+ (BOOL)pinPaiAndSpace:(NSString *)text;
//删除某些特定的字符串
+ (NSString *)deleDateSpectChacter:(NSString *)str;

+ (NSString*)dataToString:(NSData*)data;
+ (NSData*)stringtodata:(NSString*)string;

+ (UIViewController *)viewController:(UIView*)view;

//string转成base64的data
//+ (NSData*)stringtoBase64data:(NSString*)string;

//+ (NSString*)datatoBase64string:(NSData*)data;

+ (NSString*)base64stringtostring :(NSString*)string;
//
+ (NSString*)stringtobase64string :(NSString*)string;

+ (NSString*)dictojsonstring:(NSDictionary*)dic;

//+ (NSData *)base64datatodata:(NSData*)data;

+ (NSData*)base64stringtodata:(NSString*)string;

+ (NSString*)objtoSting:(NSObject*)objs;

+ (void)saveCookies;
//合适的时机加载Cookie 一般都是app刚刚启动的时候
+ (void)loadCookies;

+ (NSString*)outOfOptional:(NSString*)string;

+ (UIViewController *)getCurrentVC;

+(NSString *)ret32bitString;

//+ (NSString*)getBaseUrl;

+ (BOOL)iszhongwen:(NSString*)string;

+ (NSString *)deviceIPAdress;

+ (NSString *)getImagePath:(UIImage *)Image;

+ (NSDictionary*)getObjectData:(id)obj;

+(UIImage *)addText:(UIImage *)img text:(NSString *)text1;
//压缩图片
+(UIImage *)scaleImage:(UIImage *)image;

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
//检测当前ip ipv6地址
+(NSString *)getIPAddress;

//为数字添加标点
+(NSString *)countNumAndChangeformat:(NSString *)num;
//验证邮箱
+(BOOL)isEmai:(NSString *)input;
+(BOOL)isFax:(NSString *)input;
//验证银行卡
+(BOOL)isBankNumber:(NSString*)input;
//竞价保留三位小数 目前为最多保留三位小数
+(NSString *)setNumberWithThreePoint:(NSString*)number;
//给价格添加逗号
+(NSString *)addPointForMoney:(NSString *)money;

//将且仅将UILabel上的所有数字变色指定的字体颜色
+(NSMutableAttributedString *)textBecomeColor:(NSString *)str;
//金额输入判断
+(NSString*)textInputWithMoney:(NSString*)text;
//数量输入验证
+(NSString*)textInputWithNumber:(NSString*)text;

+ (UIWindow *)setupKeyWindow;
@end

