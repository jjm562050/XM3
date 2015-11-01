//
//  IntentionVideoModel.h
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface IntentionVideoModel : BaseModel

@property (copy,nonatomic) NSString *wbody;//文本
@property (copy,nonatomic) NSString *vplay_url;//视频链接
@property (copy,nonatomic) NSString *vpic_small;//图片
@property (copy,nonatomic) NSString *likes;//喜欢的人，点赞的


@end
