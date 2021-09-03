//
//  ViewController.m
//  URLEncryptDemo
//
//  Created by 忘词 on 2021/9/3.
//
#import "JSSafeTool.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test];
}
-(void)test{
    
//    //AES
    
    NSLog(@"test");
    NSLog(@"jiami===%@",[JSSafeTool AES256CBC_developEncryptString:@"wangci_ios"]);
    NSLog(@"jiemi===%@",[JSSafeTool AES256CBC_developDecryptString:@"RNpmUlUX3l4/57WwlYMyhw=="]);
    
    NSLog(@"jiami===%@",[JSSafeTool AES256CBC_productEncryptString:@"wangci_ios---999hshdkhfk0000"]);
    NSLog(@"jiemi===%@",[JSSafeTool AES256CBC_productDecryptString:@"0thje5WwbwCbQ8DnMYBcaIFkYe7idcM+fcgpdJLdflo="]);
    
    
    NSLog(@"jiami===%@",[JSSafeTool AES256CBC_developEncryptString:@"wangci99999" iv:@"l0MTJOmgP5TkTzBB"]);
    NSLog(@"jiami===%@",[JSSafeTool AES256CBC_developDecryptString:@"CCJtevx1VnZ7upaHrz4JGw==" iv:@"l0MTJOmgP5TkTzBB"]);
    
    NSLog(@"jiami===%@",[JSSafeTool AES256CBC_productEncryptString:@"wangci22222222" iv:@"l0MTJOmgP5TkTzBB"]);

    NSLog(@"jiami===%@",[JSSafeTool AES256CBC_productDecryptString:@"87QL6sJaTq5e3hsP3++VZA==" iv:@"l0MTJOmgP5TkTzBB"]);


    

    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI2bvVLVYrb4B0raZgFP60VXY\ncvRmk9q56QiTmEm9HXlSPq1zyhyPQHGti5FokYJMzNcKm0bwL1q6ioJuD4EFI56D\na+70XdRz1CjQPQE3yXrXXVvOsmq9LsdxTFWsVBTehdCmrapKZVVx6PKl7myh0cfX\nQmyveT/eqyZK1gYjvQIDAQAB\n-----END PUBLIC KEY-----";
    //
    NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMjZu9UtVitvgHS\ntpmAU/rRVdhy9GaT2rnpCJOYSb0deVI+rXPKHI9Aca2LkWiRgkzM1wqbRvAvWrqK\ngm4PgQUjnoNr7vRd1HPUKNA9ATfJetddW86yar0ux3FMVaxUFN6F0KatqkplVXHo\n8qXubKHRx9dCbK95P96rJkrWBiO9AgMBAAECgYBO1UKEdYg9pxMX0XSLVtiWf3Na\n2jX6Ksk2Sfp5BhDkIcAdhcy09nXLOZGzNqsrv30QYcCOPGTQK5FPwx0mMYVBRAdo\nOLYp7NzxW/File//169O3ZFpkZ7MF0I2oQcNGTpMCUpaY6xMmxqN22INgi8SHp3w\nVU+2bRMLDXEc/MOmAQJBAP+Sv6JdkrY+7WGuQN5O5PjsB15lOGcr4vcfz4vAQ/uy\nEGYZh6IO2Eu0lW6sw2x6uRg0c6hMiFEJcO89qlH/B10CQQDDdtGrzXWVG457vA27\nkpduDpM6BQWTX6wYV9zRlcYYMFHwAQkE0BTvIYde2il6DKGyzokgI6zQyhgtRJ1x\nL6fhAkB9NvvW4/uWeLw7CHHVuVersZBmqjb5LWJU62v3L2rfbT1lmIqAVr+YT9CK\n2fAhPPtkpYYo5d4/vd1sCY1iAQ4tAkEAm2yPrJzjMn2G/ry57rzRzKGqUChOFrGs\nlm7HF6CQtAs4HC+2jC0peDyg97th37rLmPLB9txnPl50ewpkZuwOAQJBAM/eJnFw\nF5QAcL4CYDbfBKocx82VX/pFXng50T7FODiWbbL4UnxICE0UBFInNNiWJxNEb6jL\n5xd0pcy9O2DOeso=\n-----END PRIVATE KEY-----";
    
    NSString * fullURLStr = @"https://site5200-web.y5fat.com/api/control/group/auth/sysBasic/v1/getSysTime";
   
    NSLog(@"testfullPath====%@", [JSSafeTool RSA_encryptFullURLStringWithDefaultPubkeyFullURLString:fullURLStr]);
    NSString * host = @"https://site5200-web.y5fat.com/";
    NSString * path = @"/api/control/group/auth/sysBasic/v1/getSysTime";
    
    NSLog(@"testhostandPath====%@", [JSSafeTool RSA_encryptURLStringWithDefaultPubkeyBaseURL:host URLString:path]);
    
    NSLog(@"=====---------%@",[JSSafeTool RSA_decryptStringWithDefaultPubkey:nil]);




    NSString *originString = @"hello world!";
    for(int i=0; i<4; i++){
        originString = [originString stringByAppendingFormat:@" %@", originString];
    }
    NSString *encWithPubKey;
    NSString *decWithPrivKey;
    NSString *encWithPrivKey;
    NSString *decWithPublicKey;
    
    NSLog(@"Original string(%d): %@", (int)originString.length, originString);
    
    // Demo: encrypt with public key
    encWithPubKey = [JSSafeTool RSA_encryptString:originString publicKey:pubkey];
    NSLog(@"Enctypted with public key: %@", encWithPubKey);
    // Demo: decrypt with private key
    decWithPrivKey = [JSSafeTool RSA_decryptString:encWithPubKey privateKey:privkey];
    NSLog(@"Decrypted with private key: %@", decWithPrivKey);
    
    // by PHP
    encWithPubKey = @"CKiZsP8wfKlELNfWNC2G4iLv0RtwmGeHgzHec6aor4HnuOMcYVkxRovNj2r0Iu3ybPxKwiH2EswgBWsi65FOzQJa01uDVcJImU5vLrx1ihJ/PADUVxAMFjVzA3+Clbr2fwyJXW6dbbbymupYpkxRSfF5Gq9KyT+tsAhiSNfU6akgNGh4DENoA2AoKoWhpMEawyIubBSsTdFXtsHK0Ze0Cyde7oI2oh8ePOVHRuce6xYELYzmZY5yhSUoEb4+/44fbVouOCTl66ppUgnR5KjmIvBVEJLBq0SgoZfrGiA3cB08q4hb5EJRW72yPPQNqJxcQTPs8SxXa9js8ZryeSxyrw==";
    decWithPrivKey = [JSSafeTool RSA_decryptString:encWithPubKey privateKey:privkey];
    NSLog(@"(PHP enc)Decrypted with private key: %@", decWithPrivKey);
    
    // Demo: encrypt with private key
    encWithPrivKey = [JSSafeTool RSA_encryptString:originString privateKey:privkey];
    NSLog(@"Enctypted with private key: %@", encWithPrivKey);

    // Demo: decrypt with public key
    decWithPublicKey = [JSSafeTool RSA_decryptString:encWithPrivKey publicKey:pubkey];
    NSLog(@"(PHP enc)Decrypted with public key: %@", decWithPublicKey);
    
}

@end
