//
//  ViewController.m
//  TYYSDKDemo
//
//  Created by Rey on 2018/8/24.
//  Copyright © 2018年 TYY. All rights reserved.
//

#import "ViewController.h"
#import <TYYSDK/TYYSDK-Swift.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *gameIdTextView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) NSString * userId;
@end

@implementation ViewController


NSString * userId;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //崩溃后下一次启动App会提示是否上传崩溃日志
    [TYYSDK setReportWithReport:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)initsdk:(id)sender {
    [self textPrint:@"开始初始化..."];
    
    [TYYSDK setDebugWithDebug:true];
    
    __weak typeof(self) weakSelf = self;
    
    [[TYYSDK share] initSdkWithInitCallback:^(InitState state, NSString * _Nullable msg) {
        
        switch (state) {
            case InitStateSuccess:
                [weakSelf textPrint:@"初始化成功"];
                
                break;
                
            case InitStateFailed:
                if (msg != nil) {
                    [weakSelf textPrint:[NSString stringWithFormat:@"初始化失败%@",msg]];
                }
                else
                {
                   [weakSelf textPrint:@"初始化失败"];
                }
                
                break;
            case InitStateNeedUpdate:
                [weakSelf textPrint:@"需要更新"];
                break;
        }
        
    } loginCallback:^(LoginState state, TYYLoginResultData * _Nullable data) {
        
        if (data != nil)
        {
            weakSelf.userId = data.id;
            [weakSelf textPrint:[NSString stringWithFormat:@"登录数据: %@",data.id]];
        }
        
        
        switch (state) {
            case LoginStateSuccess:
                [weakSelf textPrint:@"登录成功"];
                break;
                
            case LoginStateFailed:
                //注意:失败时 data 可能是 null
                [weakSelf textPrint:@"登录失败"];
                break;
        }
        
    } payCallback:^(PayState state, TYYPayData * _Nonnull data) {
        [weakSelf textPrint:[NSString stringWithFormat:@"支付数据: %@",data.msg]];
        switch (state) {
            case PayStateSuccess:
                [weakSelf textPrint:@"支付成功"];
                break;
                
            case PayStateFailed:
                [weakSelf textPrint:@"支付失败"];
                break;
            case PayStateCancel:
                [weakSelf textPrint:@"取消支付"];
                break;
            case PayStateUnknown:
                [weakSelf textPrint:@"未知错误"];
                break;
        }
    } logoutCallback:^( LogoutState state, NSString * _Nullable msg){
        //SDK 主动登出触发该回调，游戏调用 logout()接口不会收到该回调
        //用户登出回调（需要收到该回调需要返回游戏登录界面，并调用 login 接口，打开 SDK 登录界面）
        
        
        switch (state) {
                
            case LogoutStateNormal:
                [weakSelf textPrint:@"SDK退出"];
                break;
            case LogoutStateLogin_Invalid:
                [weakSelf textPrint:@"用户被挤掉,需重新登录"];
                
                [[TYYSDK share] login];
                
                break;
            case LogoutStateSwitch_Account:
                [weakSelf textPrint:@"切换账户"];
                
                [[TYYSDK share] login];
                
                break;
        }
    }];
    
}
- (IBAction)loginsdk:(id)sender {
    [self textPrint:@"开始登录..."];
    [[TYYSDK share] login];
}
- (IBAction)rechargesdk:(id)sender {
    [self textPrint:@"开始游戏充值..."];
    
    NSString * moneyStr = self.moneyTextView.text;
    
    if (moneyStr == nil) {
        [self textPrint:@"请输入金额"];
        return;
    }
    
    TYYPayUploadParams * uploadData = [[TYYPayUploadParams alloc] init];
    
    
    uploadData.roleId = self.userId;//测试使用,请使用真实id
    uploadData.cporderSN = @"123123123";
    uploadData.amount = moneyStr.doubleValue;
    uploadData.productName = @"测试产品";
    uploadData.attach = @"";
    [[TYYSDK share] pay:uploadData];
}
- (IBAction)homeviewsdk:(id)sender {
    [self textPrint:@"开始显示主界面..."];
    
    [[TYYSDK share] showMainView];
}
- (IBAction)uploadRole:(id)sender {
    [self textPrint:@"开始上传角色..."];
    
    TYYUserInfoUploadParams * info = [[TYYUserInfoUploadParams alloc] init];
    
    info.roleId = self.userId;//测试使用,请使用真实id;
    
    __weak typeof(self) weakSelf = self;
    
    [[TYYSDK share] uploadUserInfo:info callback:^(enum NormalState state, NSString * _Nullable msg) {
        switch (state) {
            case NormalStateSuccess:
                [weakSelf textPrint:@"上传成功"];
                break;
            case NormalStateFailed:
                if (msg != nil)
                {
                    [weakSelf textPrint:[NSString stringWithFormat:@"上传失败: %@",msg]];
                }
                else
                {
                    [weakSelf textPrint:@"上传失败"];
                }
                break;
        }
    }];
}
- (IBAction)uploadChat:(id)sender {
    [self textPrint:@"开始上传聊天..."];
    
    TYYChatUploadParams * data = [[TYYChatUploadParams alloc] init];
    data.roleId = self.userId;//测试使用,请使用真实id
    data.content = @"测试内容";
    data.roleName = @"角色名称";
    data.typeName = @"测试类型";
    
    __weak typeof(self) weakSelf = self;
    
    [[TYYSDK share] uploadChat:data
                      callback:^(enum NormalState state, NSString * _Nullable msg) {
                          switch (state) {
                              case NormalStateSuccess:
                                  [weakSelf textPrint:@"上传成功"];
                                  break;
                              case NormalStateFailed:
                                  if (msg != nil)
                                  {
                                      [weakSelf textPrint:[NSString stringWithFormat:@"上传失败: %@",msg]];
                                  }
                                  else
                                  {
                                      [weakSelf textPrint:@"上传失败"];
                                  }
                                  break;
                          }
                      }];
    
    
}
- (IBAction)logout:(id)sender {
    [self textPrint:@"开始注销..."];
    [[TYYSDK share] logout];
}

- (void)textPrint:(NSString *)text{
    NSLog(@"%@",text);
    
    [TYYSDK showToastWithMsg:text];
    
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",text,self.textView.text];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇一摇显示隐藏悬浮框使用
    [super motionBegan:motion withEvent:event];
}

@end
