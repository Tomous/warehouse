//
//  DCJsApi.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/3.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCJsApi.h"
@interface DCJsApi ()
//{
//    NSTimer * timer ;
//    void(^hanlder)(id value,BOOL isComplete);
//    int value;
//}

@end
@implementation DCJsApi
/** 初始化title，同步方法，及时返回H5结果 */
//-(void)configWebViewBarSync:(NSDictionary *)info {
//    if (_delegate && [_delegate respondsToSelector:@selector(setNavTitle:)]) {
//        [_delegate setNavTitle:info];
//    }
//}

-(void)testSyn:(NSDictionary *)info {
    if (_delegate && [_delegate respondsToSelector:@selector(setNavTitle:)]) {
        [_delegate setNavTitle:info];
    }
}
- (void) testAsyn:(NSString *) msg :(JSCallback) completionHandler
{
    completionHandler([msg stringByAppendingString:@" [ asyn call]"],YES);
}

- (void)testNoArgSyn:(NSDictionary *) args
{
    if (_delegate && [_delegate respondsToSelector:@selector(setNavTitle:)]) {
        [_delegate setNavTitle:args];
    }
}
//
//- ( void )testNoArgAsyn:(NSDictionary *) args :(JSCallback)completionHandler
//{
//    completionHandler(@"testNoArgAsyn called [ asyn call]",YES);
//}
//
//- ( void )callProgress:(NSDictionary *) args :(JSCallback)completionHandler
//{
//    value=10;
//    hanlder=completionHandler;
//    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
//                                              target:self
//                                            selector:@selector(onTimer)
//                                            userInfo:nil
//                                             repeats:YES];
//}
//
//-(void)onTimer{
//    if(value!=-1){
//        hanlder([NSNumber numberWithInt:value--],NO);
//    }else{
//        hanlder(0,YES);
//        [timer invalidate];
//    }
//}
//
///**
// * Note: This method is for Fly.js
// * In browser, Ajax requests are sent by browser, but Fly can
// * redirect requests to native, more about Fly see  https://github.com/wendux/fly
// * @param requestInfo passed by fly.js, more detail reference https://wendux.github.io/dist/#/doc/flyio-en/native
// */
//-(void)onAjaxRequest:(NSDictionary *) requestInfo  :(JSCallback)completionHandler{
//
//}
@end
