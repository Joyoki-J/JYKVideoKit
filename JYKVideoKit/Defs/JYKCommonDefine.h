//
//  JYKCommonDefine.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/22.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#ifndef JYKCommonDefine_h
#define JYKCommonDefine_h

#define JYK_INIT_UNAVAILABLE - (instancetype)init NS_UNAVAILABLE; \
                             + (instancetype)new  NS_UNAVAILABLE;

#define JYK_WEAK_SELF   __weak typeof(self) weakSelf = self;
#define JYK_STRONG_SELF __strong typeof(weakSelf) strongSelf = weakSelf;

#endif /* JYKCommonDefine_h */
