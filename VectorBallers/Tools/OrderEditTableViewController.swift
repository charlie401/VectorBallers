//
//  OrderEditTableViewController.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/21.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit
enum fromWhichController {

    case alarmViewController
    case alarmDetaiViewController
}
class OrderEditTableViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,AECApiManagerProvider,AECApiManagerCallBackProtocol {
    var alarmDataSourceDatail : AlarmDetailDataSource?
    var alarmDataSource :AlarmTableViewCellDataSource?
    var navigationTitleNameString : String?
    var dotName : String?
    var fromVCto : fromWhichController?
    var lastSuperView : UIView?
    var dataArray : [OrderUserVo]?
    var dataTypeArray : String?
    let activity = UIActivityIndicatorView.init(activityIndicatorStyle: .WhiteLarge)
    var paidanVC = PaiDanViewController()
    var choiceVC = ChoiceOrderTypeTabC(style: .Plain)
    let coverView = UIView()
    var orderEdit : AECOrderRightApiManager?
    @IBOutlet weak var orderTitleView: UIView!
    @IBOutlet weak var timeTotalView: UIView!
    @IBOutlet weak var orderPersonView: UIView!
    @IBOutlet weak var ooderDsciTextView: UITextView!
    @IBOutlet weak var orderTitleTF: OrderTextField!
    @IBOutlet weak var alarmDsLabel: UILabel!
    @IBOutlet weak var alarmDetailDsLabel: UILabel!
    @IBOutlet weak var orderTime: UITextField!
    @IBOutlet weak var typeChoiceLabel: UILabel!
    @IBOutlet weak var personChoiceLabel: UILabel!
    @IBOutlet weak var choicePersonLabelBixuan: UILabel!
    @IBOutlet weak var orderTypeLabelBIXuan: UILabel!
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var orderTypeView: UIView!
    
    func getAlarmId() -> String{
        if fromVCto == fromWhichController.alarmViewController{
            return (alarmDataSource?.alarmID)!
        }else {
            return (alarmDataSourceDatail?.alarmID)!
        }
    }
    
    func getOrderCode() -> String{
        if fromVCto == fromWhichController.alarmViewController{
            let randomNum = random()%1001
            let str = String(format: "%d",randomNum)
            return "WO" + (alarmDataSource?.strDateWithOrderID)! + str
            
        }else {
            let randomNum = random()%1001
            let str = String(format: "%d",randomNum)
            return "WO" + (alarmDataSourceDatail?.strDateWithOrderID)! + str
            
        }
    }

    //MARK: -AECApiManagerProvider & AECApiManagerCallBackProtocol
    func urlPathComponentForManager(manager: AECApiBaseManager) -> String {
        return SignOnViewController.getUrl()! + "/app/sendOrder.action"
    }
    
    func parametersForManager(manager: AECApiBaseManager) -> Dictionary<String, AnyObject>? {
        var dict = [String : AnyObject]()
        dict["alarmId"] = getAlarmId()
        dict["orderCode"] = getOrderCode()
        dict["detail"] = ooderDsciTextView.text
        var ids = [String]()
        for data in dataArray!{
        ids.append(data.userAccount!)
             }
        dict["accountList"] = ids
        dict["orderTypeId"] = dataTypeArray
        dict["timeLimit"] = orderTime.attributedText?.string
        dict["title"] = orderTitleTF.text
        dict["sendAccount"] = SignOnViewController.getUserName()
        
        
        debugPrint(dict,"~~~~~~~~~~~~~~~~")
        return HttpParameterAssembler.assembleParameter(dict)
    }
    
    func managerCallAPIDidSuccess(manager: AECApiBaseManager) {
        activity.stopAnimating()
        coverView.removeFromSuperview()
        
        let responseDic = orderEdit!.ResponseRawData
        
        
        switch ((responseDic?.objectForKey("result")) as? String)
        {
        case "success"?:
            let alert = UIAlertView(title: "请求成功", message: "派单成功", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        default : break
        }
    }
    
    func managerCallAPIDidFailed(manager: AECApiBaseManager, errorCode: String?) {
        activity.stopAnimating()
        coverView.removeFromSuperview()
        
        if errorCode == nil
        {
            let alert = UIAlertView(title: "请求失败", message: "无法连接至服务器", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        else
        {
            switch errorCode
            {
            case "ERROR_SYSTEM"?:
                
                let alert = UIAlertView(title: "请求失败", message: "系统错误", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                
            case "ERROR_PARAM_ERROR"?:
                
                let alert = UIAlertView(title: "请求失败", message: "参数错误", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                
            case "ERROR_ORDERED"?:
                let alert = UIAlertView(title: "请求失败", message: "已经派单，禁止再次派单", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            case "ERROR_ORDER_PRIVILEGE"?:
                let alert = UIAlertView(title: "请求失败", message: "派单无权限", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            case "ERROR_ALARMINFO_NOT_EXIST"?:
                let alert = UIAlertView(title: "请求失败", message: "未恢复告警不存在", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            case "ERROR_ALARMINFO_ END"?:
                let alert = UIAlertView(title: "请求失败", message: "告警结束，不允许派单，结束代表该告警被确认", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            case "ERROR_ORDER_TYPE"?:
                let alert = UIAlertView(title: "请求失败", message: "工单类型错误", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            default:break
                
            }
            
        }
    }
    
      //MARK: - touchEvents
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    func orderTypeViewClick() {
     
        orderPersonView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        orderTypeView.backgroundColor = UIColor.init(rIn255: 45, gIn255: 50, bIn255: 56)
        navigationController?.pushViewController(choiceVC, animated: true)

    }
    func orderPersonViewClick(){
        orderTypeView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        navigationController?.pushViewController(paidanVC, animated: true)
      
        orderPersonView.backgroundColor = UIColor.init(rIn255: 45, gIn255: 50, bIn255: 56)
    }
    // 派单按钮点击
    @IBAction func oderBtnClick(sender: AnyObject) {
        
        // 校验
        if orderTitleTF.text == ""{}
        else if orderTime.text == ""{}
        
        coverView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.3)
        coverView.addSubview(activity)
        activity.center = view.center
        activity.startAnimating()
        coverView.frame = view.bounds
        view.addSubview(coverView)
        // 发送请求
        orderEdit = AECOrderRightApiManager(urlProvider:self)
        orderEdit!.apiCallBackDelegate = self
        orderEdit!.loadData()
        
    }
    func orderTimeSet(textFiled : UITextField){

        if  textFiled.text == "" {
            textFiled.text = "1"
        }
        let str = textFiled.text! as NSString
        let num = str.intValue
        if num > 240{
            
            textFiled.text = "240"
        }
    }
     //MARK: - SYSTEMLIFE
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        paidanVC.callClosure { [weak self](data) in
            if data.count == 0{
                self!.personChoiceLabel.text = nil
                self!.choicePersonLabelBixuan.hidden = false

            }else{
            self!.dataArray = data
             self!.personChoiceLabel.text = data[0].userName
             self!.choicePersonLabelBixuan.hidden = true
            }
        }
        choiceVC.orderTypeBlock{ [weak self](data) in
            
            self!.dataTypeArray = data.id
            self!.orderTypeLabelBIXuan.hidden = true
            self!.typeChoiceLabel.text = data.typeName
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
          if fromVCto == .alarmViewController && alarmDataSource != nil{
            navigationItem.title = alarmDataSource?.mainName
            if dotName == nil{ orderTitleTF.text = (alarmDataSource?.mainName)!}
            else{
                 orderTitleTF.text = (alarmDataSource?.mainName)! + dotName!
            }
           
            self.alarmDsLabel.numberOfLines = 0
            let str = (alarmDataSource?.description)! as NSString
            let substr = str.componentsSeparatedByString("告警触发值")
            self.alarmDsLabel.text = (alarmDataSource?.area)! + (alarmDataSource?.mainName)! + substr[0]
            self.alarmDetailDsLabel.text = "告警触发值" + substr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) + "    时间: " + (alarmDataSource?.strDateStandardization)!

            setUpUI()
            
            
         }else {
         
            if navigationTitleNameString == ""{
                orderTitleTF.text = (alarmDataSourceDatail?.dotName)!
                
                let str = (alarmDataSourceDatail?.alarmDescription)! as NSString
                let substr = str.componentsSeparatedByString("告警触发值")
                
                self.alarmDsLabel.text = /*(alarmDataSource?.area)! + */substr[0]
                self.alarmDetailDsLabel.text = "告警触发值" + substr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) + "    时间: " + (alarmDataSourceDatail?.strDateStandardization)!

                setUpUI()

            }else{
            navigationItem.title = navigationTitleNameString
            orderTitleTF.text = navigationTitleNameString! + (alarmDataSourceDatail?.dotName)!
                let str = (alarmDataSourceDatail?.alarmDescription)! as NSString
                let substr = str.componentsSeparatedByString("告警触发值")
                self.alarmDsLabel.text = /*(alarmDataSource?.area)! +*/ navigationTitleNameString! + substr[0]
                self.alarmDetailDsLabel.text = "告警触发值" + substr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) + "    时间: " + (alarmDataSourceDatail?.strDateStandardization)!
                setUpUI()
               
        
        }
        }
        
    }
    

    func setUpUI(){
        orderTitleTF.delegate = self
        orderTime.delegate = self
        orderTime.attributedPlaceholder = NSAttributedString(string: "1 ", attributes: [NSFontAttributeName : UIFont.init(name: "PingFangSC-Regular", size: 15)!,NSForegroundColorAttributeName : UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139)])
        orderTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(OrderEditTableViewController.orderTypeViewClick)))
        orderPersonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(OrderEditTableViewController.orderPersonViewClick)))
        orderBtn.layer.cornerRadius = 5.0
        orderBtn.layer.masksToBounds = true
        orderTime.text = "1"
        orderTime.addTarget(self, action: #selector(OrderEditTableViewController.orderTimeSet(_:)), forControlEvents: .EditingChanged)
        ooderDsciTextView.textColor = UIColor.init(rIn255: 123, gIn255: 132, bIn255: 148)
        ooderDsciTextView.delegate = self
       
    }
 
//MARK: - textFielddelegete
    func textFieldDidEndEditing(textField: UITextField) {
        lastSuperView?.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        
        
        if textField === orderTitleTF{
            if textField.text == ""
            {
                 showAlertView("确定", stringMessage: "工单标题不能为空")
                textField.becomeFirstResponder()
                return
            }
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField === orderTitleTF{
            if orderTitleTF.text != "" {
                orderTitleTF.resignFirstResponder()
                orderTime.becomeFirstResponder()
            }
       
        }
        return true
    }
    func  showAlertView(stringTitle : String, stringMessage : String,btnTitle : String = "确认")  {
        let alertView = UIAlertView()
        alertView.title = stringTitle
        alertView.message = stringMessage
        alertView.addButtonWithTitle(btnTitle)
        
        alertView.show()
    }
   
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = nil
     
        orderTypeView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        orderPersonView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        textField.superview!.backgroundColor = UIColor.init(rIn255: 45, gIn255: 50, bIn255: 56)
        lastSuperView = textField.superview!
        textField.tintColor = UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139)
        textField.textColor = UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139)
        
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        orderTypeView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        orderPersonView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        return true
    }
    func textViewDidChange(textView: UITextView) {
      
        if textView.text.characters.count > 300{
        
            let str = textView.text as NSString
            let substr = str.substringWithRange(NSRange.init(location: 0, length: 300))
            textView.text = substr

        }
    }

    
    deinit{
        print("OrderEditTableViewController - deinit")
    }


}



