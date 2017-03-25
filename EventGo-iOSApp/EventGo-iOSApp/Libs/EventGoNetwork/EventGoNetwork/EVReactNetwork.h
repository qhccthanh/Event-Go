//
//  EVReactNetwork.h
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventGoCommon/EventGoCommon.h>

@interface EVReactNetwork : NSObject
- (RACSignal *)requestWithMethod:(NSString *)method
                          header:(NSDictionary *)headers
                       urlString:(NSString *)urlString
                          params:(NSDictionary *)param
                            body:(NSString *)bodyString;
@end
