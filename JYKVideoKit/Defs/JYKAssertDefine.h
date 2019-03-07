//
//  JYKAssertDefine.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/7.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define JYKSafeValueAssert(flag, returnValue) \
if (!(flag)) {                                \
    return (returnValue);                     \
}


#endif /* Header_h */
