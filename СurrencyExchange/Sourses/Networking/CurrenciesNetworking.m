//
//  CurrenciesNetworking.m
//  currencies
//
//  Created by Joe Franc on 1/3/18.
//  Copyright © 2018 Joe Franc. All rights reserved.
//

#import "CurrenciesNetworking.h"
#import "AFNetworking.h"

static NSString const *currenciesURL = @"https://api.fixer.io/latest";

@interface CurrenciesNetworking  ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CurrenciesNetworking

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    }
    return self;
}

-(void)loadGETRequest:(NSDictionary *)parameters requestCompletion:(RequestCompletionBlock)completion{

    [self.manager GET:[NSString stringWithFormat:@"%@", currenciesURL] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion) {
            completion(nil, error);
        }
    }];
}

@end
