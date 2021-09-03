//
//  JSSafeTool.m
//  RSA Base64 test
//
//  Created by 忘词 on 2021/7/20.
//

#import "JSSafeTool.h"
#import "RSA.h"
#import "MJEncryptStringData.h"
#import <CommonCrypto/CommonCrypto.h>


//测试、开发环境公钥
static NSString * const debugPubkey = @"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDN5bNL3Mzx8ZYFnXRjfXF+vNxsmaCZ2TnBj4LUOCz+RyoOByxBUf7Y3Z72VtHQiiqK8Qk5f3APkrpSSzXlw6/bJtLdeNZiAoBwkTJDllLQdJ3OGrnlhQulF/ANwT4jJ+47/p2UDZ6vpGZtyB1YF2EGGyAivQ5RmDe8UiwoTuG4DwIDAQAB-----END PUBLIC KEY-----";

//生产环境公钥
static NSString * const releasePubkey = @"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDmIrCUS9HObBLeV1Vunp0NxGF/nCaIfw5DKNRriqeykTQNTnVxOclnHEOKZE3xsUiaHNCA75nvpIZmMV33taDPEhow4xAg/1qm73/EAbK3LOHtZYZIwUeE1FfqusfWOkti4G3H7OO2dzYU0oItFs39FdBJ/EXAEFGErSuCA7VhLQIDAQAB-----END PUBLIC KEY-----";

static NSString * const spliceStr = @"RoaVGWBm";
//
////AESkey  _2623610917  _2623610917
static NSString * const developAESKEY = @"noQkdQQwvm51c4wfA7b85y1PU1NPcMnr";
//AES IV  _2481238613
static NSString * const developAESIV = @"l0MTJOmgP5TkTzBB";
//_1086244826
static NSString * const productAESKEY = @"ijKM6P37qVUUpMQSGFhiA5C1caWOg5iS";
//AES IV _553135094
static NSString * const productAESIV = @"Bj4NJWXN9f7fRxNn";
@implementation JSSafeTool

#pragma mark ---  AES

+ (NSString *)AES256CBC_developEncryptString:(NSString *)string{
    
    return [self encryptString:string keyString:mj_OCString(_2623610917) iv:mj_OCString(_2481238613)];
}


+ (NSString *)AES256CBC_developEncryptString:(NSString *)string iv:(NSString *)iv{
    return [self encryptString:string keyString:mj_OCString(_2623610917) iv:iv];

}
    

+ (NSString *)AES256CBC_developDecryptString:(NSString *)string{
    return [self decryptString:string keyString:mj_OCString(_2623610917) iv:mj_OCString(_2481238613)];

}


+ (NSString *)AES256CBC_developDecryptString:(NSString *)string iv:(NSString *)iv{
    return [self decryptString:string keyString:mj_OCString(_2623610917) iv:iv];

}

//上产
+ (NSString *)AES256CBC_productEncryptString:(NSString *)string{
    return [self encryptString:string keyString:mj_OCString(_1086244826) iv:mj_OCString(_553135094)];

}

+ (NSString *)AES256CBC_productEncryptString:(NSString *)string iv:(NSString *)iv{
    return [self encryptString:string keyString:mj_OCString(_1086244826) iv:iv];

}


+ (NSString *)AES256CBC_productDecryptString:(NSString *)string{
    return [self decryptString:string keyString:mj_OCString(_1086244826) iv:mj_OCString(_553135094)];

}


+ (NSString *)AES256CBC_productDecryptString:(NSString *)string iv:(NSString *)iv{
    return [self decryptString:string keyString:mj_OCString(_1086244826) iv:iv];

}

+ (NSString *)encryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSString *)iv {
    
    // 设置秘钥
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[kCCKeySizeAES256];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:kCCKeySizeAES256];
    // 设置iv
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cIv[kCCBlockSizeAES128];
    bzero(cIv, kCCBlockSizeAES128);
    [ivData getBytes:cIv length:kCCBlockSizeAES128];
    
    // 设置输出缓冲区
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // 开始加密
    size_t encryptedSize = 0;
    //加密解密都是它 -- CCCrypt
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES256,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
    }
    
    return [result base64EncodedStringWithOptions:0];
}
    
+ (NSString *)decryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSString *)iv {
    
    // 设置秘钥
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[kCCKeySizeAES256];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:kCCKeySizeAES256];
    
    // 设置iv
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cIv[kCCBlockSizeAES128];
    bzero(cIv, kCCBlockSizeAES128);
    [ivData getBytes:cIv length:kCCBlockSizeAES128];

    
    // 设置输出缓冲区
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // 开始解密
    size_t decryptedSize = 0;
    /**CCCrypt 对称加密算法的核心函数（加密/解密）
     参数：
     1、kCCEncrypt 加密/kCCDecrypt 解密
     2、加密算法、默认的 AES/DES
     3、加密方式的选项
        kCCOptionPKCS7Padding | kCCOptionECBMode;//ECB加密！
        kCCOptionPKCS7Padding;//CBC 加密！
     4、加密密钥
     5、密钥长度
     6、iv 初始化向量，ECB 不需要指定
     7、加密的数据
     8、加密的数据长度
     9、缓冲区（地址），存放密文的
     10、缓冲区的大小
     11、加密结果大小
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES256,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 解密失败|状态编码: %d", cryptStatus);
    }
    
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}





//NSString * fullURLStr = @"https://site5200-web.y5fat.com/api/control/group/auth/sysBasic/v1/getSysTime";

+ (NSString *)RSA_encryptFullURLStringWithDefaultPubkeyFullURLString:(NSString *)fullURLStr{
    if (fullURLStr == nil ) {
        return nil;
    }
    if (fullURLStr.length == 0) {
        return @"";
    }
    NSRange range = [fullURLStr rangeOfString:@"/api/"];
    if (range.location != NSNotFound) {
        NSLog(@"found at location = %lu, length = %lu",(unsigned long)range.location,(unsigned long)range.length);
        NSString * hostStr = [fullURLStr substringToIndex:range.location + 1];
        NSString * pathStr = [fullURLStr substringFromIndex:range.location +1];

        NSLog(@"%@====%@",hostStr,pathStr);
        return [self RSA_encryptURLStringWithDefaultPubkeyBaseURL:hostStr URLString:pathStr];
    }
    return nil;
}

//NSString * baseURL = @"https://site5200-web.y5fat.com/";
//NSString * praStr = @"api/control/group/auth/sysBasic/v1/getSysTime";
//NSString * preStr = @"RoaVGWBm";

+ (NSString *)RSA_encryptURLStringWithDefaultPubkeyBaseURL:(NSString *)baseURLStr URLString:(NSString *)urlStr{
    
    if (baseURLStr == nil || urlStr == nil) {
        return nil;
    }
    if (baseURLStr.length == 0 || urlStr.length == 0) {
        return @"";
    }
    
    if ([baseURLStr hasSuffix:@"/"]) {
        if ([urlStr hasPrefix:@"/"]) {
            NSString * newStr = [urlStr substringFromIndex:1];
            NSString * encWithPubKey = [self RSA_encryptStringWithDefaultPubkey:newStr];
            return [NSString stringWithFormat:@"%@%@%@",baseURLStr,spliceStr,encWithPubKey];
        }else{
            NSString * encWithPubKey = [self RSA_encryptStringWithDefaultPubkey:urlStr];
            return [NSString stringWithFormat:@"%@%@%@",baseURLStr,spliceStr,encWithPubKey];
        }
    }else{
        if ([urlStr hasPrefix:@"/"]) {
            NSString * encWithPubKey = [self RSA_encryptStringWithDefaultPubkey:urlStr];
            return [NSString stringWithFormat:@"%@%@%@",baseURLStr,spliceStr,encWithPubKey];
        }else{
            NSString * newUrlStr = [@"/" stringByAppendingString:urlStr];
            NSString * encWithPubKey = [self RSA_encryptStringWithDefaultPubkey:newUrlStr];
            return [NSString stringWithFormat:@"%@%@%@",baseURLStr,spliceStr,encWithPubKey];
        }
    }
    
    


}

+ (NSString *)RSA_encryptStringWithDefaultPubkey:(NSString *)str{
    if (str == nil ) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA encryptString:str publicKey:mj_OCString(_2949200664)];

}


+ (NSString *)RSA_encryptStringWithDefaultReleasePubkey:(NSString *)str{
    if (str == nil ) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA encryptString:str publicKey:mj_OCString(_2096543319)];
}


+ (NSData *)RSA_encryptDataWithDefaultPubkey:(NSData *)data{
    if (data == nil ) {
        return nil;
    }
    return [RSA encryptData:data publicKey:mj_OCString(_2949200664)];
}

//+ (NSString *)RSA_encryptStringWithDefaultPrivKey:(NSString *)str{
//    return [RSA encryptString:str privateKey:mj_OCString(_3943473686)];
//}

//+ (NSData *)RSA_encryptDataWithDefaultPrivKey:(NSData *)data{
//    return [RSA encryptData:data privateKey:mj_OCString(_3943473686)];
//}

+ (NSString *)RSA_decryptStringWithDefaultPubkey:(NSString *)str{
    if (str == nil ) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA decryptString:str publicKey:mj_OCString(_2949200664)];
}

+ (NSString *)RSA_decryptStringWithDefaultReleasePubkey:(NSString *)str{
    if (str == nil ) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA decryptString:str publicKey:mj_OCString(_2096543319)];
}

+ (NSData *)RSA_decryptDataWithDefaultPubkey:(NSData *)data{
    if (data == nil ) {
        return nil;
    }
    return [RSA decryptData:data publicKey:mj_OCString(_2949200664)];
}

//+ (NSString *)RSA_decryptStringWithDefaultPrivKey:(NSString *)str{
//    return [RSA decryptString:str privateKey:mj_OCString(_3943473686)];
//}

//+ (NSData *)RSA_decryptDataWithDefaultPrivKey:(NSData *)data{
//    return [RSA decryptData:data privateKey:mj_OCString(_3943473686)];
//}

+ (NSString *)RSA_encryptString:(NSString *)str publicKey:(NSString *)pubKey{
    if (str == nil || pubKey == nil) {
        return nil;
    }
    if (str.length == 0 || pubKey.length == 0) {
        return @"";
    }

    return [RSA encryptString:str publicKey:pubKey];
}

+ (NSData *)RSA_encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    
 
    if (data == nil || pubKey.length == 0 ||pubKey == nil) {
        return nil;
    }
    
    
    return [RSA encryptData:data publicKey:pubKey];
}


+ (NSString *)RSA_encryptString:(NSString *)str privateKey:(NSString *)privKey{
    if (str == nil || privKey == nil || privKey.length == 0) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA encryptString:str privateKey:privKey];
}


+ (NSData *)RSA_encryptData:(NSData *)data privateKey:(NSString *)privKey{
    if (data == nil || privKey.length == 0 ||privKey == nil) {
        return nil;
    }
    return [RSA encryptData:data privateKey:privKey];
}

+ (NSString *)RSA_decryptString:(NSString *)str publicKey:(NSString *)pubKey{
    if (str == nil || pubKey == nil || pubKey.length == 0) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA decryptString:str publicKey:pubKey];
}

+ (NSData *)RSA_decryptData:(NSData *)data publicKey:(NSString *)pubKey{
    
    if (data == nil || pubKey.length == 0 ||pubKey == nil) {
        return nil;
    }
    
    return [RSA decryptData:data publicKey:pubKey];
}


+ (NSString *)RSA_decryptString:(NSString *)str privateKey:(NSString *)privKey{
    if (str == nil || privKey.length == 0 || privKey == nil) {
        return nil;
    }
    if (str.length == 0) {
        return @"";
    }
    return [RSA decryptString:str privateKey:privKey];
}


+ (NSData *)RSA_decryptData:(NSData *)data privateKey:(NSString *)privKey{
    
    if (data == nil || privKey.length == 0 ||privKey == nil) {
        return nil;
    }
    return [RSA decryptData:data privateKey:privKey];
}

@end
