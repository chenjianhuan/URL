//
//  JSSafeTool.h
//  RSA Base64 test
//
//  Created by 忘词 on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSSafeTool : NSObject

#pragma mark ---  AES
/**测试环境
 *  加密字符串并返回base64编码字符串
 *
 *  @param string    要加密的字符串
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)AES256CBC_developEncryptString:(NSString *)string;


/**动态下发IV 测试环境
 *  加密字符串并返回base64编码字符串
 *
 *  @param string    要加密的字符串
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)AES256CBC_developEncryptString:(NSString *)string iv:(NSString *)iv;
    
    /**测试环境
     *  解密字符串
     *
     *  @param string    加密并base64编码后的字符串
     *
     *  @return 返回解密后的字符串
     */
+ (NSString *)AES256CBC_developDecryptString:(NSString *)string;

/**测试环境
 *  解密字符串
 *
 *  @param string    加密并base64编码后的字符串
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)AES256CBC_developDecryptString:(NSString *)string iv:(NSString *)iv;




/**生产环境
 *  加密字符串并返回base64编码字符串
 *
 *  @param string    要加密的字符串
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)AES256CBC_productEncryptString:(NSString *)string;


/**动态下发IV。生产环境
 *  加密字符串并返回base64编码字符串
 *
 *  @param string    要加密的字符串
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)AES256CBC_productEncryptString:(NSString *)string iv:(NSString *)iv;
    
    /**生产环境
     *  解密字符串
     *
     *  @param string    加密并base64编码后的字符串
     *
     *  @return 返回解密后的字符串
     */
+ (NSString *)AES256CBC_productDecryptString:(NSString *)string;

/**生产环境
 *  解密字符串
 *
 *  @param string    加密并base64编码后的字符串
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)AES256CBC_productDecryptString:(NSString *)string iv:(NSString *)iv;



#pragma mark ---  RSA


/*
 使用SDK内的公钥
 fullURLStr:完整的URL
 return  加密后的URL
 
 例如：
 NSString * fullURLStr = @"https://site5200-web.y5fat.com/api/control/group/auth/sysBasic/v1/getSysTime";
 **/
+ (NSString *)RSA_encryptFullURLStringWithDefaultPubkeyFullURLString:(NSString *)fullURLStr;
/*
 使用SDK内的公钥
 baseURLStr:域名
 urlStr：加密字符串
 return  加密后的URL
 
 例如：
 NSString * baseURLStr = @"https://site5200-web.y5fat.com/";
 NSString * urlStr = @"api/control/group/auth/sysBasic/v1/getSysTime";
 **/
+ (NSString *)RSA_encryptURLStringWithDefaultPubkeyBaseURL:(NSString *)baseURLStr URLString:(NSString *)urlStr;

/*
 使用SDK内的测试公钥
 str:要加密的字符串
 return base64 encoded string
 **/
+ (NSString *)RSA_encryptStringWithDefaultPubkey:(NSString *)str;

/*
 使用SDK内的生产公钥
 str:要加密的字符串
 return base64 encoded string
 **/
+ (NSString *)RSA_encryptStringWithDefaultReleasePubkey:(NSString *)str;

/*
 使用SDK内的公钥
 data:要加密的data
 return raw data
 **/
+ (NSData *)RSA_encryptDataWithDefaultPubkey:(NSData *)data;

/*
 使用SDK内的私钥
 str:要加密的字符串
 return base64 encoded string
 **/
//+ (NSString *)RSA_encryptStringWithDefaultPrivKey:(NSString *)str;

/*
 使用SDK内的私钥
 data:要加密的data
 return raw data
 **/
//+ (NSData *)RSA_encryptDataWithDefaultPrivKey:(NSData *)data;

/*
 使用SDK内的测试公钥
 str:要解密的字符串（base64）
 decrypt base64 encoded string, convert result to string(not base64 encoded)
 */
+ (NSString *)RSA_decryptStringWithDefaultPubkey:(NSString *)str;



/*
 使用SDK内的公钥
 data:要解密的data
 */
+ (NSData *)RSA_decryptDataWithDefaultPubkey:(NSData *)data;

/*
 使用SDK内的私钥
 str:要解密的字符串（base64）
 */
//+ (NSString *)RSA_decryptStringWithDefaultPrivKey:(NSString *)str;

/*
 使用SDK内的私钥
 data:要解密的data
 */
//+ (NSData *)RSA_decryptDataWithDefaultPrivKey:(NSData *)data;

/*
 str:要加密的字符串
 pubKey：公钥
 return base64 encoded string
 **/
+ (NSString *)RSA_encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/*
 data:要加密的data
 pubKey：公钥
 return raw data
 **/
+ (NSData *)RSA_encryptData:(NSData *)data publicKey:(NSString *)pubKey;

/*
 str:要加密的字符串
 privKey：私钥
 return base64 encoded string
 **/
+ (NSString *)RSA_encryptString:(NSString *)str privateKey:(NSString *)privKey;

/*
 data:要加密的data
 privKey：私钥
 return raw data
 **/
+ (NSData *)RSA_encryptData:(NSData *)data privateKey:(NSString *)privKey;

/*
 str:要解密的字符串（base64）
 pubKey：公钥
 decrypt base64 encoded string, convert result to string(not base64 encoded)
 */
+ (NSString *)RSA_decryptString:(NSString *)str publicKey:(NSString *)pubKey;

/*
 data:要解密的data
 pubKey：公钥
 */
+ (NSData *)RSA_decryptData:(NSData *)data publicKey:(NSString *)pubKey;

/*
 str:要解密的字符串（base64）
 pubKey：私钥
 */
+ (NSString *)RSA_decryptString:(NSString *)str privateKey:(NSString *)privKey;

/*
 data:要解密的data
 pubKey：私钥
 */
+ (NSData *)RSA_decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
