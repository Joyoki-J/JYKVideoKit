//
//  JYKAssertDefine.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/7.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#ifndef JYKAssertDefine_h
#define JYKAssertDefine_h

#define JYKSafeAssert(flag, returnValue) \
if (!(flag)) {                           \
    return (returnValue);                \
}


#endif /* Header_h */
