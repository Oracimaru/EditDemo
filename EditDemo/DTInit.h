//
//  DTInit.h
//  forum
//
//  Created by lixiaolin on 13-10-13.
//  Copyright (c) E度事业部. All rights reserved.
//

#define DEBUGCONFIG       //调试版本

//#define ENTERPRISE        //打AppStore版的包时注释掉该宏

#ifndef kaoyan_DTInit_h
#define kaoyan_DTInit_h

#ifndef ENTERPRISE
#define KGroupID @"group.com.tal.kaoyanclub"
#else
#define KGroupID @"group.com.tal.kaoyanforum"
#endif

//调试信息输出控制
#ifdef DEBUGCONFIG
    #define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
    #define NSLog(...) printf("%s 第%d行: %s\n\n", [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
    #define NSLog(...){}
#endif

//防止警告
#define DTSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//model层缓存时间
#define URL_CACHE_LIFE_TIME  3600

//系统整体默认色
#define UIBGCOLOR_238   [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]
#define UITEXTCOLOR_153 [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]
#define UITEXTCOLOR_170 [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]
#define UILINECOLOR_220 [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]
#define UILINECOLOR_229 [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0]
#define UILINECOLOR_245 [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]
//rgb颜色
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define UITEXTCOLOR_BLUE         RGB(52, 149, 232)
#define UITEXTCOLOR_ORANGE       RGB(255,102, 0)
#define UITEXTCOLOR_LIGHTGRAY    RGB(204, 204, 204)
#define UITEXTCOLOR_TIPS         RGB(170, 170, 170)
#define UITEXTCOLOR_DETAIL       RGB(136, 136, 136)
#define UITEXTCOLOR_SUBTITLE     RGB(102, 102, 102)
#define UITEXTCOLOR_TITLE        RGB(51, 51, 51)



#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

//检测是否为空
#define DTIsNull(id) [id isEqual:[NSNull null]]

#define DT_RANDOM_0_1() ((random() / (float)0x7fffffff ))


//沙盒Documents目录
#define DOCUMENTS_DIR ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])

//沙盒Caches目录
#define CACHES_DIR ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

//用户信息路径
#define USERINFO_FILEPATH [NSString stringWithFormat:@"%@/USERINFO.plist",DOCUMENTS_DIR]

// 保存状态路径
#define STATUS_SAVE_PATH [NSString stringWithFormat:@"%@/status_%@",DOCUMENTS_DIR, [UserDataCenter defaultCenter].uid]

// 下载数据库路径
#define SUBJECT_SAVE_PATH [NSString stringWithFormat:@"%@/subject_%@",DOCUMENTS_DIR, [UserDataCenter defaultCenter].uid]
//试题答案临时保存路径
#define EXAM_ANSWER_PATH [NSString stringWithFormat:@"%@/ANSWER.plist",DOCUMENTS_DIR]
#define APPDELEGATE ((AppDelegate*)([[UIApplication sharedApplication] delegate]))
#endif

