// ----------------------------------------------------------------------
// Part of the SQLite Persistent Objects for Cocoa and Cocoa Touch
//
// Original Version: (c) 2008 Jeff LaMarche (jeff_Lamarche@mac.com)
// ----------------------------------------------------------------------
// This code may be used without restriction in any software, commercial,
// free, or otherwise. There are no attribution requirements, and no
// requirement that you distribute your changes, although bugfixes and 
// enhancements are welcome.
// 
// If you do choose to re-distribute the source code, you must retain the
// copyright notice and this license information. I also request that you
// place comments in to identify your changes.
//
// For information on how to use these classes, take a look at the 
// included Readme.txt file
// ----------------------------------------------------------------------

#if (TARGET_OS_IPHONE)
#import "NSObject-ClassName.h"
#import <objc/runtime.h>

@implementation NSObject(ClassName)
- (NSString *)className
{
	return [NSString stringWithUTF8String:class_getName([self class])];
}
+ (NSString *)className
{
	return [NSString stringWithUTF8String:class_getName(self)];
}
+ (BOOL)isEmptyContainer:(NSObject *)o{
	if (o==nil) {
		return YES;
	}
	if (o==NULL) {
		return YES;
	}
	if (o==[NSNull null]) {
		return YES;
	}
    if ([o isKindOfClass:[NSDictionary class]]) {
		return [((NSDictionary *)o) count]<=0;
	}
	if ([o isKindOfClass:[NSArray class]]) {
		return [((NSArray *)o) count]<=0;
	}
    if ([o isKindOfClass:[NSSet class]]) {
		return [((NSSet *)o) count]<=0;
	}
	return NO;
}
@end
#endif

// TODO: 上线前删除
//#warning 使用了私有 API，有审核风险，上线前删除！
//#ifdef DEBUG
//// 模拟真机内存警告
//@implementation NSObject (RHCBlockTimer)
//
//- (void)logTimeConsumptionOfBlock:(void (^)(void)) block withPrefix:(NSString*) prefixString {
//    double a = CFAbsoluteTimeGetCurrent();
//    block();
//    double b = CFAbsoluteTimeGetCurrent();
//    unsigned int runTime = ((b - a) * 1000.0f);
//    LOGI(@"%@: %d ms", prefixString ? prefixString : @"Time taken", runTime);
//}
//+(void)sendMemoryWarning{
//    SEL memoryWarningSel = @selector(_performMemoryWarning);
//    if ([[UIApplication sharedApplication] respondsToSelector:memoryWarningSel]) {
//        [[UIApplication sharedApplication] performSelector:memoryWarningSel];
//    }else {
//        DMLog(@"%@",@"Whoops UIApplication no loger responds to -_performMemoryWarning");
//    }
//}
//@end
//#endif



