// CsTokenGrabber.m
//  labs2020mobile
//
//  Created by Oleksii Skliarenko on 11.05.2021.
//

#import "CsTokenGrabber.h"
#import <SAMKeychain/SAMKeychain.h>
#import <React/RCTBridgeModule.h>

NSString *const CURSecureStoreService = @"com.curiosity.CURSecureStoreService";
NSString *const CURSecureStoreLoggedInAccount = @"com.curiosity.CURSecureStoreLoggedInAccount";

@interface CsTokenGrabber() <RCTBridgeModule>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSUserDefaults *store;

@end

@implementation CsTokenGrabber
RCT_EXPORT_MODULE();

+ (instancetype)shared {
    return [[CsTokenGrabber alloc] initWithAccount:CURSecureStoreLoggedInAccount];
}

- (instancetype)initWithAccount:(NSString *)account {
    self = [super init];
    if (self) {
      _account = account;
    }
    return self;
}

- (BOOL)deleteAuthToken {
    BOOL result = [SAMKeychain deletePasswordForService:CURSecureStoreService
                                                account:CURSecureStoreLoggedInAccount];
    return result;
}

- (void)setAuthToken:(NSString *)authToken {
    [SAMKeychain setPassword:authToken forService:CURSecureStoreService account:self.account];
}

- (nullable NSString *)authToken {
    NSString *token = [SAMKeychain passwordForService:CURSecureStoreService account:self.account];
    return token;
}

RCT_EXPORT_METHOD(authToken:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  resolve([[CsTokenGrabber shared] authToken]);
}

RCT_EXPORT_METHOD(deleteAuthToken:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  BOOL isDeleted = [[CsTokenGrabber shared] deleteAuthToken];
  resolve([[NSNumber alloc] initWithBool:isDeleted]);
}

@end
