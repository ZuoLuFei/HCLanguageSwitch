/*******************************************************************************
# File        : HCLocalizableManager-OC.h
# Project     : BBSport
# Author      : ZuoLuFei
# Created     : 2020/9/3
# Corporation : ****
# Description : OC版国际化工具
 *******************************************************************************/
 
/**
 *  国际化匹配
 */
#define OC_DEF_LOCALIZED_STRING(String) [HCLocalizableManager_OC localized:String]

#define OC_DEF_LOCALIZED_IMAGE(String) [[HCLocalizableManager_OC share] imageOf:String]

#define OC_DEF_LOCALIZED_IMAGE_STRING(String) [[HCLocalizableManager_OC share] imageStringOf:String]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HCLocalizableManager_OC : NSObject

/// 单例
+(HCLocalizableManager_OC *) share;

+ (NSString *)currentName;

/// 获取国际化文本
/// @param key 健值
+ (NSString *)localized:(NSString *)key;

/// 获取国际化图片
- (UIImage *)imageOf:(NSString *)key;

/// 获取国际化图片字符串
- (NSString *)imageStringOf:(NSString *)key;


@end
