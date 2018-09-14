//
//  ViewController.swift
//  TYYSDKDemoSwift
//
//  Created by Rey on 2018/8/24.
//  Copyright © 2018年 TYY. All rights reserved.
//

import UIKit
import TYYSDK


class ViewController: TYYViewController {

    var userId:String = ""
    
    @IBOutlet weak var textView:UITextView!
    
    @IBOutlet weak var gameIdTextView:UITextField!
    @IBOutlet weak var moneyTextView:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //崩溃后下一次启动App会提示是否上传崩溃日志
        TYYSDK.setReport(report: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func initsdk(_ sender: Any) {
        textPrint("开始初始化...")
        
        TYYSDK.setDebug(debug: true)
        
        TYYSDK.share().initSdk(initCallback: {[weak self] (state, msg) in
            
            switch state
            {
            case .Success:
                self?.textPrint("初始化成功")
            case .Failed:
                if let errorMsg = msg
                {
                    self?.textPrint("初始化失败: \(errorMsg)")
                }
                else
                {
                    self?.textPrint("初始化失败")
                }
            case .NeedUpdate:
                self?.textPrint("需要更新")
            }
            
            }, loginCallback: {[weak self] (state, data) in
                
                
                if let loginData = data
                {
                    self?.userId = loginData.id
                    self?.textPrint("登录数据: \(loginData.id)")
                }
                
                switch state
                {
                case .Success:
                    self?.textPrint("登录成功")
                case .Failed:
                    //注意:失败时 data 可能是 null
                    self?.textPrint("登录失败")
                case .Cancel:
                    self?.textPrint("取消登录")
                    
                    //建议重新走登录流程
                    TYYSDK.share().login()
                }
                
            }, payCallback: {[weak self] (state, data) in
                self?.textPrint("支付数据: \(data.msg)")
                switch state
                {
                case .Success:
                    self?.textPrint("支付成功")
                case .Failed:
                    self?.textPrint("支付失败")
                case .Cancel:
                    self?.textPrint("取消支付")
                case .Unknown:
                    self?.textPrint("未知错误")
                }
        }) {[weak self](state, data)in
            //SDK 主动登出触发该回调，游戏调用 logout()接口不会收到该回调
            //用户登出回调（需要收到该回调需要返回游戏登录界面，并调用 login 接口，打开 SDK 登录界面）
//            self?.textPrint("SDK退出")
            
            switch state
            {
                
            case .Normal:
                self?.textPrint("SDK退出")
            case .Login_Invalid:
                self?.textPrint("用户被挤掉,需重新登录")
                
                
                //建议重新走登录流程
                TYYSDK.share().login()
            case .Switch_Account:
                self?.textPrint("切换账户")
                //建议重新走登录流程
                TYYSDK.share().login()
            }
        }
    }
    
    @IBAction func loginsdk(_ sender: Any) {
        textPrint("开始登录...")
        TYYSDK.share().login()
    }
    @IBAction func rechargesdk(_ sender: Any) {
        textPrint("开始游戏充值...")
        
        guard let money = Double(moneyTextView.text!) else {
            textPrint("请输入金额")
            return
        }
        
        let uploadData = TYYPayUploadParams()
        uploadData.roleId = userId//测试使用,请使用真实id
        uploadData.cporderSN = "123123123"
        uploadData.amount = money
        uploadData.productName = "测试"
        uploadData.attach = ""
        TYYSDK.share().pay(uploadData)
    }
    @IBAction func homeviewsdk(_ sender: Any) {
        textPrint("开始显示主界面...")
        TYYSDK.share().showMainView()
    }
    
    @IBAction func uploadRole(_ sender: Any) {
        textPrint("开始上传角色...")
        let info = TYYUserInfoUploadParams()
        info.roleId = userId
        
        TYYSDK.share().uploadUserInfo(info) {[weak self] (state, msg) in
            switch state
            {
            case .Success:
                self?.textPrint("上传成功")
            case .Failed:
                self?.textPrint("上传失败 \(msg!)")
            }
        }
    }
    
    @IBAction func uploadChat(_ sender: Any) {
        
        textPrint("开始上传聊天...")
        
        let data = TYYChatUploadParams()
        
        data.roleId = userId//测试使用,请使用真实id
        data.content = "测试内容"
        data.roleName = "角色名称"
        data.typeName = "测试类型"
        
        TYYSDK.share().uploadChat(data) {[weak self] (state, msg) in
            switch state
            {
            case .Success:
                self?.textPrint("上传成功")
            case .Failed:
                self?.textPrint("上传失败 \(msg!)")
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        textPrint("开始注销...")
        TYYSDK.share().logout()
    }
    
    func textPrint(_ text:String) {
        print(text)
        TYYSDK.showToast(msg: text)
        textView.text = "\(text)\n\(textView.text!)"
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
    }

}

