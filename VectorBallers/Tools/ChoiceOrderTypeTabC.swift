//
//  ChoiceOrderTypeTabC.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/22.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit

class ChoiceOrderTypeTabC: UITableViewController,AECApiManagerProvider,AECApiManagerCallBackProtocol  {
    typealias orderTypeValueBlock = (OrderTypeVo) -> ()
    var request : AECOrderRightApiManager?
    var orderTypeB :orderTypeValueBlock?
    var dataMutableA = [OrderTypeVo]()
    func orderTypeBlock(orderT : orderTypeValueBlock?) {
        orderTypeB = orderT
    }
    
    override init(style: UITableViewStyle) {
        
        
        super.init(style: style)
        
        request = AECOrderRightApiManager(urlProvider: self)
        request!.apiCallBackDelegate = self
        request!.loadData()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "选择工单类型"
        self.tableView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        tableView.registerClass(oderTypeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.rowHeight = 44.0
        tableView.separatorColor = UIColor.init(rIn255: 29, gIn255: 28, bIn255: 32)
        // 发送请求
        
        
    }
    // MARK: - AECApiManagerProvider&&AECApiManagerCallBackProtocol
    
    func managerCallAPIDidSuccess(manager: AECApiBaseManager) {
        
        if manager is AECOrderRightApiManager{
            let responseDic = request!.ResponseRawData
            switch ((responseDic?.objectForKey("result")) as? String){
            case "success"?:
                var dataMArray : [Dictionary<String,AnyObject>]
                dataMArray = responseDic!["orderTypes"] as! [Dictionary<String,AnyObject>]
                
                for dataA in dataMArray{
                    let paid = OrderTypeVo.orderType(dataA)
                    
                    dataMutableA.append(paid)
                    
                }
                
                tableView.reloadData()
                
            default: break
            }
        }
        
    }
    
    func managerCallAPIDidFailed(manager: AECApiBaseManager, errorCode: String?) {
        if errorCode == nil{
            
            debugPrint("ERROR_nil")
        }else if errorCode == "ERROR_SYSTEM"{
            
            debugPrint("ERROR_SYSTEM")
        }
        else if errorCode == "ERROR_PARAM_ERROR"{
            
            debugPrint("ERROR_PARAM_ERROR")
        }
        
    }
    
    func urlPathComponentForManager(manager: AECApiBaseManager) -> String {
        return SignOnViewController.getUrl()! + "/app/orderTypes.action"
    }
    func parametersForManager(manager: AECApiBaseManager) -> Dictionary<String, AnyObject>? {
        return HttpParameterAssembler.assembleParameter(nil)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataMutableA.count
        
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as!oderTypeTableViewCell
        cell.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        cell.setHighlighted(false, animated: true)
        let data = dataMutableA[indexPath.row]
        cell.textLabel?.attributedText = NSAttributedString(string: data.typeName!, attributes: [NSFontAttributeName : UIFont.init(pingFangSize: 17),NSForegroundColorAttributeName:UIColor.init(rIn255: 184, gIn255: 207, bIn255: 230)])
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let backview = UIView()
        backview.backgroundColor = UIColor.init(rIn255: 45, gIn255: 50, bIn255: 56)
        backview.frame = (tableView.cellForRowAtIndexPath(indexPath)?.bounds)!
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selectedBackgroundView =  backview
        let data = self.dataMutableA[indexPath.row]
        
        if orderTypeB != nil {
            orderTypeB!(data)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
    }
    
}
