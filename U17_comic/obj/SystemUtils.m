//
//  SystemUtils.m
//  Test
//
//  Created by jusa on 16/5/30.
//  Copyright © 2016年 jusa. All rights reserved.
//

#import "SystemUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <objc/runtime.h>

@implementation SystemUtils

//为数字加逗号
+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

// 屏幕宽度
+ (CGFloat)screenWidth {
    static CGFloat width = 0;
    if (width == 0) {
        width = MIN(CGRectGetHeight([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]));
    }
    return width;
}

// 屏幕高度
+ (CGFloat)screenHeight {
    static CGFloat height = 0;
    if (height == 0) {
        height = MAX(CGRectGetHeight([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]));
    }
    return height;
}

+ (BOOL)getOCIsIphoneX {
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusHeight > 20) {
        return true;
    }
    return false;
}

+ (CGFloat)zSafeArea_Bottom {
    if([self getOCIsIphoneX]) {
        return 34;
    }
    return 0;
}

// 获取颜色
+ (UIColor*)RGBA:(int)r g:(int)g b:(int)b alpha:(float)a {
    return [UIColor colorWithRed:(float)r/0xff green:(float)g/0xff blue:(float)b/0xff alpha:a];
}

// 获取颜色
+ (UIColor*)RGB:(int)r g:(int)g b:(int)b {
    return [self RGBA:r g:g b:b alpha:1.0f];
}

//字幕 数字 中文
+ (BOOL)isLigleCharacters:(NSString*)nama{
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL bo = [pred evaluateWithObject:nama];
    return bo;
}

+ (BOOL)isEmailAddress: (NSString *)candidate {
    if (candidate == nil) {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)isNumberAndCharecter:(NSString*)input{
    ///
    if (input == nil) {
        return NO;
    }
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:input]) {
        return YES;
    }
    return NO;
}

+(BOOL)isPassword:(NSString*)input{
    if (input == nil) {
        return NO;
    }
    NSString *pass = @"^((?=.*?\\d)(?=.*?[A-Za-z])|(?=.*?\\d)(?=.*?[!#@$%&?？'*+,#:.^-_`{|}~*?])|(?=.*?[A-Za-z])(?=.*?[!#@$%&?？'*+,#:.^-_`{|}~*?]))[\\dA-Za-z!#@$%&?？'*+,#:.^-_`{|}~*?]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pass];
    if (![pred evaluateWithObject:input]) {
        return YES;
    }
    return NO;
}

+(BOOL)isNumber:(NSString *)input{
    
    NSString* NUMBERS = @"0.10123456789";
    NSCharacterSet* cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString* filtered = [[input componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [input isEqualToString:filtered];
    return basicTest;
}

+(BOOL)isIntNumber:(NSString *)input{
    
    NSString* NUMBERS = @"10123456789";
    NSCharacterSet* cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString* filtered = [[input componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [input isEqualToString:filtered];
    
    return basicTest;
}

+(BOOL)isNumberAndTwoNumber:(NSString *)input{
    
    NSString *regex = @"^\\-?([0-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}

+(BOOL)isNumberAndThreeNumber:(NSString *)input{
    NSString *regex = @"^\\-?([0-9]\\d*|0)(\\.\\d{0,3})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}

+(BOOL)pinPaiAndSpace:(NSString *)text{
    NSString *regex = @"^[a-zA-Z0-9\\s\\u4e00-\\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:text];
    return isMatch;
}

+(NSString *)deleDateSpectChacter:(NSString *)str{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if ( c == ' ' || c == ':' || c == '-' ) { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?=.*[a-zA-Z0-9])(?=.*[_#@!~%^&*])[a-zA-Z0-9_#@!~%^&*]{8,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)isPhonenumber:(NSString*)number{
    if (number == nil) {
        return NO;
    }
    NSString *emailRegex = @"[^0-9]/g";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailTest evaluateWithObject:number]){
        if (number.length == 11) {
            NSString *num = [number substringToIndex:1];
            if ([num isEqual: @"1"]) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

//"^[a-zA-Z]\w{5,19}$"
+ (BOOL)isgoodpwd:(NSString*)ninput{
    if (ninput == nil) {
        return NO;
    }
    NSString *emailRegex = @"[^a-zA-Z0-9]/g";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:ninput]){
        NSLog(@"...");
    }
    return ![emailTest evaluateWithObject:ninput];
}

///^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/

+(BOOL)iscarpad:(NSString*)input{
    if (input == nil) {
        return NO;
    }
    NSString *shou = [input substringToIndex:1];
    NSString *lu = @"京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙吉闽贵粤青藏川宁琼陕";
    NSString *A250 = [input substringFromIndex:1];
    //NSLog(@"%@,%@",shou,A250);
    if ([lu rangeOfString:shou].length > 0){
        NSString *emailRegex = @"^[A-Z]{1}[A-Z_0-9]{5}$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if ([emailTest evaluateWithObject:A250]){
            NSLog(@"...");
        }
        return [emailTest evaluateWithObject:A250];
    }else{
        return NO;
    }
}

//字符串转成md5
+ (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *ymd5 = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    
    return [ymd5 lowercaseString];
}
/*
 * 描述：计算字符串绘制在屏幕上的宽度
 * 参数：要绘制的字符串
 * 参数：字体
 * 返回值：绘制的宽度
 */
+ (CGFloat)widthForString:(NSString*)aString
                 withFont:(UIFont*)font
{
    // 根据文字长度计算
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(2000, 100)
                                        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    
    
    // 返回宽度
    return rect.size.width;
}

/**31W -> 1000W
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    // 根据文字长度计算
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                      context:nil];
    
    return rect.size.height;
}

//微博粉丝数
+ (NSString*)followersCount:(NSString*)num {
    
    if (!num) {
        return @"0";
    }
    
    float folo = [num floatValue];
    if (folo > 10000){
        float count = folo / 10000;
        return [NSString stringWithFormat:@"%.1f%@",count,@"万人"];
    }else{
        return [NSString stringWithFormat:@"%.0f",folo];
    }
}

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
        
    
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return returnImage;
}


/*
 * 描述：字符串转换为日期格式
 * 参数：时间
 * 返回值：2012-12-11 10:00:00
 */
+ (NSDate*)getTime:(NSString*) playTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    [format setLocale:enLocale];
    [format setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
    NSDate *dateTime = [format dateFromString:playTime];
    return dateTime;
}

+ (NSString*)nowTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

/*
 * 描述：根据日期生成显示的字符串
 * 参数：时间
 * 返回值：
 */
+ (NSString*)stringByTime:(NSDate*)time
{
    // 当前时间到|time|的秒数
    NSInteger seconds = [[NSNumber numberWithDouble:([time timeIntervalSinceNow] * -1)] integerValue];
    
    if (seconds < 0) {
        return @"";
    }
    else if (seconds < 60){
        return [NSString stringWithFormat:@"%ld秒前",(long)seconds];
    }
    else if (seconds < 60*60){
        return [NSString stringWithFormat:@"%ld分钟前",seconds/60];
    }
    else if (seconds < 60*60*24){
        return [NSString stringWithFormat:@"%ld小时前",seconds/60/60];
    }
    else if (seconds < 60*60*24*365){
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"MM-dd HH:mm:ss"];
        return [formater stringFromDate:time];
    }
    else {
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formater stringFromDate:time];
    }
    
    return @"";
}

//截取图片
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

//
+ (UIImage*)getPreViewImg:(NSURL*)url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return img;
}

/*
 * 描述：判断字符串里是否包含表情
 * 参数：字符串
 * 返回值：
 */
+(BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         }
         else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         }
         else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    
    return isEomji;
    
}

/*
 * 描述：生成GUID
 * 参数：无
 * 返回值：无
 */
+ (NSString*)createGUID
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge  NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);// 注意此处使用ARC模式
    CFRelease(uuidObject);
    
    return uuidStr;
}

/*
 * 描述：压缩图片
 * 返回值：无
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)image
{
    //UIImage 压缩后的图片
    UIImage *newImage = nil;
    
    //原图片大小
    CGSize imageSize = image.size;
    //原图片宽度
    CGFloat width = imageSize.width;
    //原图片高度
    CGFloat height = imageSize.height;
    
    
    //欲压缩宽度
    CGFloat targetWidth = targetSize.width;
    //欲压缩高度
    CGFloat targetHeight = targetSize.height;
    //压缩比例系数（初始化为0）
    CGFloat scaleFactor = 0.5;
    //图片的宽度和高度小于欲压缩的宽度和高度，不需要压缩
    if (width <= targetWidth && height <= targetHeight) {
        return image;
    }
    //图片的宽度和高度都等于0，不需要压缩
    if (width == 0 || height == 0) {
        
        return image;
    }
    
    //宽度比例
    CGFloat scaledWidth = targetWidth;
    //高度比例
    CGFloat scaledHeight = targetHeight;
    //压缩点
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    /*
     如果 原图片大小跟欲压缩大小相同，则不执行压缩动作，否则执行压缩动作
     执行：
     */
    if ((CGSizeEqualToSize(imageSize, targetSize) == NO)&&(imageSize.width!=0)&&(imageSize.height!=0))
    {
        //宽度系数，格式 50／100＝0.5
        CGFloat widthFactor = targetWidth / width;
        //高度系数 格式 50／100＝0.5
        CGFloat heightFactor = targetHeight / height;
        
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        
        //压缩后的宽度＝原宽度＊宽度压缩系数
        scaledWidth  = width * scaleFactor;
        //压缩后的宽度＝原高度＊高度压缩系数
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    //以下执行压缩动作
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [image drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
    return newImage;
}

//将UIView转成UIImage,将UIImage转成PNG/JPG//
+(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 计算文件的md5
+ (NSString*)MD5forFile:(NSString*)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didnt exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 4 * 1024 ];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

// 获取文件的大小
+ (NSInteger)getFileSize:(NSString*)path
{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize])) {
            return  [theFileSize intValue];
        }
    }
    
    return -1;
}


//数字验证
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

//顾名思义
+ (NSString*)dataToString:(NSData*)data{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData*)stringtodata:(NSString*)string{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (UIViewController *)viewController:(UIView*)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//string转成base64的data
+ (NSData*)stringtoBase64data:(NSString*)string{
    if (string == nil || string.length == 0) {
        return [[NSData alloc] init];
    }
    NSData* sampleData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString * base64String = [sampleData base64EncodedStringWithOptions:0];
    NSData* dataFromString = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return dataFromString;
}

//base64的data转成string

+ (NSString*)datatoBase64string:(NSData*)data{
    //    if (data == nil) {
    //        return @"";
    //    }
    NSString * base64String = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    NSData* dataFromString = [[NSData alloc] initWithBase64EncodedString:base64String options:1];
    NSString * string = [NSString stringWithUTF8String:[dataFromString bytes]];
    return string;
}

+ (NSString*)base64stringtostring :(NSString*)string{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:1];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    text = [text stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    return [text stringByReplacingOccurrencesOfString:@"<\"\">" withString:@""];
}

+ (NSData*)base64stringtodata:(NSString*)string{
    NSString * base64String = [SystemUtils base64stringtostring:string];
    NSData* dataFromString = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    return dataFromString;
}

+ (NSData *)base64datatodata:(NSData*)data{
    NSString * base64String = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    
    NSData* dataFromString = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return dataFromString;
}

//字典转成jsonString
+ (NSString*)dictojsonstring:(NSDictionary*)dic{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSString*)stringtobase64string :(NSString*)string{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    return base64String;
}

//获取数据转成string 避免nsnumber问题
+ (NSString*)objtoSting:(NSObject *)objs{
    NSString *string = @"";
    if (objs == nil) {
        return string;
    }
    if ([objs isKindOfClass:[NSNumber class]]) {
        string =  [(NSNumber*)objs stringValue];
    }else{
        string = [NSString stringWithFormat:@"%@",objs];
    }
    return string;
}

//合适的时机保存Cookie
+ (void)saveCookies{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"org.skyfox.cookie"];
    [defaults synchronize];
}

//合适的时机加载Cookie 一般都是app刚刚启动的时候
+ (void)loadCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"org.skyfox.cookie"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}
//
+ (NSString*)outOfOptional:(NSString*)string{
    if (string.length == 0) {
        return @"";
    }else{
        return string;
    }
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [SystemUtils setupKeyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
    
    
}

// 32随机字符串

+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}


//是否是中文
+ (BOOL)iszhongwen:(NSString*)string{
    BOOL ish = NO;
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            ish = YES;
        }
    }
    return ish;
}
+(NSInteger )judgeChineseAndChacterLength:(NSString *)text{
   
    NSInteger length = [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - text.length) / 2;
    length = (length +1) / 2;
    return length;
}
//ip
+ (NSString *)deviceIPAdress {
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}


/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}
//上部依赖
+ (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}

//改大小
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat targetHeight = defineWidth / imageSize.width * imageSize.height;
    UIGraphicsBeginImageContext(CGSizeMake(defineWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,defineWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 *  压缩图片
 */
+(UIImage *)scaleImage:(UIImage *)image{
    
    // 原始数据
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    // 原始图片
    UIImage *result = [UIImage imageWithData:imgData];
    
    while (imgData.length > 1000) {
        imgData = UIImageJPEGRepresentation(result, 0.5);
        result = [UIImage imageWithData:imgData];
    }
    return result;
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //上下文的大小
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);//设置颜色
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "TrebuchetMS-Bold", 28, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetShadowWithColor(context, CGSizeMake(1, 1), 1,[UIColor blackColor].CGColor);
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);//设置字体绘制的颜色
    CGContextShowTextAtPoint(context, (w-strlen(text)*text1.length)/2 , h/2, text, strlen(text));//设置字体绘制的位置
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
}

+ (NSString *)getIPAddress
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            //sa_type == AF_INET ||
            if( sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

+ (NSString *)digitUppercase:(NSString *)money {
   
    NSString * numstr = money;
    if ([numstr containsString:@","]){
      numstr =  [numstr stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    double numberals=[numstr doubleValue];
    
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    
    //金额乘以100转换成字符串（去除圆角分数值）
    
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    
    NSString *prefix;
    
    NSString *suffix;
    
    if (valstr.length<=2) {
        
        prefix=@"零元";
        
        if (valstr.length==0) {
            
            suffix=@"零角零分";
            
        } else if (valstr.length==1) {
            
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
            
        } else {
            
            NSString *head=[valstr substringToIndex:1];
            
            NSString *foot=[valstr substringFromIndex:1];
            
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
            
        }
        
    }else{
        
        prefix=@"";
        
        suffix=@"";
        
        NSInteger flag = valstr.length - 2;
        
        NSString *head = [valstr substringToIndex:flag-1];
        
        NSString *foot = [valstr substringFromIndex:flag];
        
        if (head.length > 13) {
            
            return@"金额不能大于13位,请重新输入";
            
        }
        
        //处理整数部分
        
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        
        for (int i = 0; i < head.length; i++) {
            
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            
            [ch addObject:str];
            
        }
        
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            
            int index=(ch.count -i-1) % 4; //取段内位置
            
            int indexloc = (int)( ch.count - i - 1 ) / 4; //取段位置
            
            if ([[ch objectAtIndex:i] isEqualToString:@"0"]) {
                
                zeronum++;
                
            }else{
                
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        
        prefix =[prefix stringByAppendingString:@"元"];
        if (numberals < 1) {
            prefix = @"零元";
        }
        //处理小数位
        
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        } else if ([foot hasPrefix:@"0"]) {
            
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }else{
            
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
            
        }
        
    }
    if (([suffix hasSuffix:@"零分"]) && (suffix.length > 2)){
        suffix = [suffix substringToIndex:suffix.length-2];
    }
    if (([prefix hasPrefix:@"零元"]) && (![suffix  isEqual: @"整"])){
        prefix = @"";
    }
    return [prefix stringByAppendingString:suffix];
    
}

+ (BOOL)isEmai:(NSString *)input {
    NSString *regex = @"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}
+ (BOOL)isFax:(NSString *)input {
    NSString * rege = @"((^\\d{11}$)|(^\\d{12}$))|(^\\d{3}-\\d{8}$)|(^\\d{4}-\\d{7}$)|(^\\d{4}-\\d{8}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rege];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}
+ (BOOL)isBankNumber:(NSString *)input {
    NSString * rege = @"(^\\d{19}$)|(^\\d{19}-\\d{4}$)|(^\\d{20}$)|(^\\d{16}$)|(^\\d{20}-\\d{4}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rege];
    BOOL isMatch = [pred evaluateWithObject:input];
    return isMatch;
}

+ (NSString *)setNumberWithThreePoint:(NSString *)number {
    if (number.doubleValue <= 0){
        return @"0";
    }
    NSString * numberString = [[NSString alloc] initWithFormat:@"%.3f",number.doubleValue];
    for (int i = 0; i < 3; i++){
        if ([numberString hasSuffix:@"0"] && ![numberString hasSuffix:@"."]){
            numberString = [numberString substringToIndex:numberString.length-1];
        }
        if ([numberString hasSuffix:@"."]){
            numberString = [numberString substringToIndex:numberString.length-1];
        }
    }
    return numberString;
}

+ (NSString *)addPointForMoney:(NSString *)money {
    NSString * moneyString = [[NSString alloc] initWithFormat:@"%.4f",money.doubleValue];
    int a = 1;
    if (money.doubleValue < 0){
        a = -1;
        moneyString = [[NSString alloc] initWithFormat:@"%.4f",-1.0*money.doubleValue];
    }
    NSString * zhengshu = [moneyString substringToIndex:moneyString.length-5];
    NSString * xiaoshu = [moneyString substringFromIndex:moneyString.length-4];
    xiaoshu = [[NSString alloc] initWithFormat:@"%.0f" , round(xiaoshu.doubleValue)/100+0.01];
    if (xiaoshu.doubleValue == 0){
        xiaoshu = @"00";
    }
    if (xiaoshu.length < 2){
        xiaoshu = [@"0" stringByAppendingString:xiaoshu];
    }
    zhengshu = [self countNumAndChangeformat:zhengshu];
    zhengshu = [zhengshu stringByAppendingString:@"."];
    if (a < 0){
        return  [[@"-" stringByAppendingString:zhengshu] stringByAppendingString:xiaoshu];
    }
    return [zhengshu stringByAppendingString:xiaoshu];
}
+ (NSMutableAttributedString *)textBecomeColor:(NSString *)content {
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:content];
    for (int i = 0; i < content.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName :[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:16],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
        }
        
    }
    return attributeString;
}


+ (NSString *)textInputWithMoney:(NSString *)text {
    if ([text  isEqual: @""]){
        return  @"";
    }
    NSString * resultText = text;
    if (![self isNumber:text]){
        resultText = [[NSString alloc]initWithFormat:@"%.2f",text.doubleValue];
    }else{
        if ([resultText hasPrefix:@"00"]){
            if (resultText.doubleValue > 0){
                resultText = [resultText substringFromIndex:1];
            }else{
                resultText = @"0";
            }
        }
        if ([resultText hasPrefix:@"."]){
            resultText = @"0.";
        }
        if ([resultText containsString:@"."]){
            if ([resultText containsString:@".."]){  //含..
                if ([resultText hasSuffix:@".."]){  //末尾含..
                    resultText = [resultText substringToIndex:resultText.length-1];
                }else{
                    resultText = [NSString stringWithFormat:@"%.2f",resultText.doubleValue];
                }
            }
            NSRange inde = [resultText rangeOfString:@"."];
            NSString * point = [resultText substringFromIndex:inde.location];
            NSString * removePointText = [resultText substringToIndex:inde.location];
            if (removePointText.length >= 10){
                removePointText = [removePointText substringToIndex:10];
            }
            if (point.length > 3){
                point = [point substringToIndex:3];
            }
            //判断12.3.3情况
            if ((removePointText.doubleValue < resultText.doubleValue) && [point hasSuffix:@"."]){
                point = [point substringToIndex:point.length-1];
            }
            resultText = [removePointText stringByAppendingString:point];
            //判断12.0.1
            if ( point.length > 1){
                if ([[point substringFromIndex:1] containsString:@"."]){
                    resultText = [NSString stringWithFormat:@"%.2f",resultText.doubleValue];
                }
            }
            //判断0.0.0
            if ((resultText.doubleValue <= 0) && point.length > 1){
                if ([[point substringFromIndex:1] containsString:@"."]){
                    resultText = @"0.";
                }
            }
        }else{
            if (resultText.length > 10){
                resultText = [resultText substringToIndex:10];
            }
        }
        if (resultText.doubleValue >= 1 && [text hasPrefix:@"0"]){
            if (![self isIntNumber:text]){
                resultText = [NSString stringWithFormat:@"%.2f",resultText.doubleValue];
            }else{
                resultText = [NSString stringWithFormat:@"%.0f",resultText.doubleValue];
            }
        }
    }
    return resultText;
}

+ (NSString *)textInputWithNumber:(NSString *)text {
    if ([text  isEqual: @""]){
        return  @"";
    }
    NSString * resultText = text;
    if (![self isNumber:text]){
        resultText = [[NSString alloc]initWithFormat:@"%.3f",text.doubleValue];
    }else{
        if ([resultText hasPrefix:@"00"]){
            if (resultText.doubleValue > 0){
                resultText = [resultText substringFromIndex:1];
            }else{
                resultText = @"0";
            }
        }
        if ([resultText hasPrefix:@"."]){
            resultText = @"0.";
        }

        if ([resultText containsString:@"."]){
            if ([resultText containsString:@".."]){
                if ([resultText hasSuffix:@".."]){  //末尾含..
                    resultText = [resultText substringToIndex:resultText.length-1];
                }else{
                    resultText = [NSString stringWithFormat:@"%.3f",resultText.doubleValue];
                }
            }
            NSRange inde = [resultText rangeOfString:@"."];
            NSString * point = [resultText substringFromIndex:inde.location];
            NSString * removePointText = [resultText substringToIndex:inde.location];

            //限定长度10
            if (removePointText.length >= 10){
                removePointText = [removePointText substringToIndex:10];
            }
            if (point.length > 4){
                point = [point substringToIndex:4];
            }
            if ((removePointText.doubleValue < resultText.doubleValue) && [point hasSuffix:@"."]){
                point = [point substringToIndex:point.length-1];
            }

            resultText = [removePointText stringByAppendingString:point];
            //判断12.9.93 12.0.01  12.00.1
            if (point.length > 1){
                if ([[point substringFromIndex:1] containsString:@"."]){
                    resultText = [NSString stringWithFormat:@"%.3f",resultText.doubleValue];
                }
            }
            //判断0.0.00  0.00.0
            if ((resultText.doubleValue <= 0) && point.length > 1){
                if ([[point substringFromIndex:1] containsString:@"."]){
                    resultText = @"0.";
                }
            }
        }else{
            if (resultText.length > 10){
                resultText = [resultText substringToIndex:10];
            }
        }
        if (resultText.doubleValue >= 1 && [text hasPrefix:@"0"]){
            if (![self isIntNumber:text]){
                resultText = [NSString stringWithFormat:@"%.3f",resultText.doubleValue];
            }else{
                resultText = [NSString stringWithFormat:@"%.0f",resultText.doubleValue];
            }
        }
    }
    return resultText;
}

+ (UIWindow *)setupKeyWindow {
    UIWindow* window = nil;
     
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
           if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.lastObject;
                break;
           }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}


@end

