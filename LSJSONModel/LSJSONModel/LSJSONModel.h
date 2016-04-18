//
//  LSJSONModel.h
//  LSJSONModel
//
//  Created by Dylan on 16/4/18.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSJSONModel : NSObject

// 字典转模型
-(instancetype)initWithDictionary:(NSDictionary *)dict;


// 数组转模型
+ (NSArray *)ls_modelArrayWithArray:(NSArray*)array;


@end
