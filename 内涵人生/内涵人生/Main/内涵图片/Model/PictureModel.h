//
//  PictureModel.h
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface PictureModel : BaseModel

@property (copy,nonatomic) NSString *wpic_s_width;
@property (copy,nonatomic) NSString *wpic_s_height;
@property (copy,nonatomic) NSString *wpic_m_height;
@property (copy,nonatomic) NSString *wpic_m_width;

@property (copy,nonatomic) NSString *wbody;

@property (copy,nonatomic) NSString *wpic_large;
@property (copy,nonatomic) NSString *wpic_middle;
@property (copy,nonatomic) NSString *wpic_small;

@property (copy,nonatomic) NSString *is_gif;
@property (copy,nonatomic) NSString *wid;
@property (copy,nonatomic) NSString *comments;
@property (copy,nonatomic) NSString *update_time;
@property (copy,nonatomic) NSString *likes;


//@property(copy,nonatomic)NSNumber *type;


@end
