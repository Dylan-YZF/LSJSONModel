//
//  LSJSONModel.m
//  LSJSONModel
//
//  Created by Dylan on 16/4/18.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import "LSJSONModel.h"
#import <objc/runtime.h>

@implementation LSJSONModel


// 字典转模型
-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        [self ls_modelWithDictionary:dict];
        
    }
    return self;
}


// 数组转模型
+ (NSArray *)ls_modelArrayWithArray:(NSArray*)array
{
    NSMutableArray* objectArray = [NSMutableArray array];
    for (id object in array) {
        id class = [[self alloc]initWithDictionary:object];
        [objectArray addObject:class];
    }
    
    return objectArray;
}

- (void)ls_modelWithDictionary:(NSDictionary*)dict
{
    NSArray * keyArray = [dict allKeys];
    
    unsigned  int outCount = 0 ;
    objc_property_t* propertys = class_copyPropertyList([self class], &outCount); //获取该类的属性数组
    
    for (unsigned int i = 0 ; i < outCount; i++) {
        //获得该类的一个属性
        objc_property_t property =  propertys[i];
        NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding]; //获取属性对应的名称
        
        id value = [dict valueForKey:propertyName];
        
        if (![keyArray containsObject:propertyName]||value == nil){
            continue ; // 跳过循环体中余下的语句，继续执行循环
        }
        
        NSString * propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        // 判断 attributes 有没有 ,
        NSUInteger dotLoc = [propertyAttributes rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound) { // 没有,
            //                code = [propertyAttributes substringFromIndex:loc];
        } else {
            code = [propertyAttributes substringWithRange:NSMakeRange(loc, dotLoc-loc)];
        }
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            code = [code substringWithRange:NSMakeRange(2, code.length-3)];
            value = [[NSClassFromString(code) alloc]initWithDictionary:value];
            
        }else if ([value isKindOfClass:[NSArray class]]){
            
            NSRange range = [code rangeOfString:@"<"];
            code = [code substringWithRange:NSMakeRange(range.location+1, code.length-range.location-3)];
            NSMutableArray* objectArray = [NSMutableArray array];
            for (id object in value) {
                id class = [[NSClassFromString(code) alloc]initWithDictionary:object];
                [objectArray addObject:class];
            }
            value = objectArray;
        }
        
        [self setValue:value forKey:propertyName];
    }
    free(propertys); //记得要释放
}



@end
