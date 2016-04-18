//
//  Person.h
//  ZFRuntimeModel
//
//  Created by Dylan on 16/4/7.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import "LSJSONModel.h"
#import "Clothes.h"

@protocol Person <NSObject>

@end


@interface Person : LSJSONModel

@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic) BOOL sex;//性别 YES 男  NO 女
@property (nonatomic) NSInteger age;//年龄
@property (nonatomic) float height;//身高
@property (nonatomic,copy) NSString *job;//工作

@property (nonatomic,strong) Clothes* clothes; // 衣服
@property (nonatomic,strong) NSArray  <Person>* personList;  // 朋友




@end
