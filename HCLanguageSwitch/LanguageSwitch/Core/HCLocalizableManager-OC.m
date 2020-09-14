/*******************************************************************************
 # File        : HCLocalizableManager-OC.m
 # Project     : BBSport
 # Author      : ZuoLuFei
 # Created     : 2020/9/3
 # Corporation : ****
 # Description :
 <#Description Logs#>
 ------------------------------------------------------------------------------- **/

#import "HCLocalizableManager-OC.h"

#define kBundleNameKey @"User_Language_Bundle_Name_Key"

@interface HCLocalizableManager_OC()

@property(nonatomic, strong) NSDictionary* imageDict;

@end

@implementation HCLocalizableManager_OC


static HCLocalizableManager_OC* instance = nil;

+(HCLocalizableManager_OC *) share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

+ (NSString *)currentName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* bundleName = [defaults objectForKey:kBundleNameKey];
    if ([bundleName  isEqual: @"zh-Hans"]) {
        bundleName = @"zh-CN";
    }
    return bundleName;
}

+ (NSString *)localized:(NSString *)key {
    
    NSString *value = key;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* bundleName = [defaults objectForKey:kBundleNameKey];
    if ( bundleName == nil ) {
        bundleName = @"en";
    }

    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"lproj"]];
    if (bundle != nil)  {
        value = [bundle localizedStringForKey:key value:nil table:nil];
    }
    
    
    
    return value;
}

- (UIImage *)imageOf:(NSString *)key {
    
    if (self.imageDict == nil) {
        self.imageDict = [NSDictionary dictionary];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"LocalizableImage" ofType:@"plist"];
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path];
        self.imageDict = dict;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* bundleName = [defaults objectForKey:kBundleNameKey];
    if ( bundleName == nil ) {
        bundleName = @"en";
    }
    
    NSString* imageStr = self.imageDict[bundleName][key];
    UIImage* img = [UIImage imageNamed:imageStr];
    
    return img;
}

- (NSString *)imageStringOf:(NSString *)key {
    if (self.imageDict == nil) {
        self.imageDict = [NSDictionary dictionary];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"LocalizableImage" ofType:@"plist"];
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:path];
        self.imageDict = dict;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* bundleName = [defaults objectForKey:kBundleNameKey];
    if ( bundleName == nil ) {
        bundleName = @"en";
    }
    
    NSString* imageStr = self.imageDict[bundleName][key];
    
    return imageStr;
}


@end
