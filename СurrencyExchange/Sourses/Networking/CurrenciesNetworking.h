//
//  CurrenciesNetworking.h
//  currencies
//
//  Created by Joe Franc on 1/3/18.
//  Copyright © 2018 Joe Franc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;

typedef void (^RequestCompletionBlock)(id responseObject, NSError *error);


@interface CurrenciesNetworking : NSObject



- (void)loadGETRequest:(NSDictionary *)parameters requestCompletion:(RequestCompletionBlock)completion;

@end
