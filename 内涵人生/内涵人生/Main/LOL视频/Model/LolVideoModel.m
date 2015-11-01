//
//  LolVideoModel.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "LolVideoModel.h"

@implementation LolVideoModel

- (NSDictionary*)attributeMapDictionary
{
    //   @"属性名": @"数据字典的key"
    NSDictionary*mapAtt = @{
                            @"wxID":@"id"
                            
                            };
    return mapAtt;
    
}


@end
