//
//  Clothes.h
//  ZFRuntimeModel
//
//  Created by Dylan on 16/4/7.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import "LSJSONModel.h"

@interface Clothes : LSJSONModel



@property (nonatomic,copy) NSString *name;//衣服名
@property (nonatomic) BOOL type;   // YES 男装  NO 女装
@property (nonatomic) NSInteger size;// 大小
@property (nonatomic) float width;// 衣服宽


@end
