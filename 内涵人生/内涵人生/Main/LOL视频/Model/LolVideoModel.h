//
//  LolVideoModel.h
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface LolVideoModel : BaseModel

@property (copy,nonatomic) NSString *youku_id;
@property (copy,nonatomic) NSString *wxID;
@property (copy,nonatomic) NSString *icon;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *url;
@property (copy,nonatomic) NSString *pop;
@property (copy,nonatomic) NSString *detail;


@end
