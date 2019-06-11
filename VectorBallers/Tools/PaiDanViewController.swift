//
//  PaiDanViewController.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 16/7/7.
//  Copyright © 2016年 AEC. All rights reserved.
//

import UIKit
import SDWebImage
class PaiDanViewController: UITableViewController,AECApiManagerProvider,AECApiManagerCallBackProtocol {
    
    typealias choicePersonBtnBlcok = ([OrderUserVo]) -> ()
    
    var dataMutableArray = [OrderUserVo]()
    var dataSortArray = [OrderUserVo]()
    var titleArray =  [[String : [OrderUserVo]]]()
    var request : AECOrderRightApiManager?
    var choicePersonBtnArrayBlcok : choicePersonBtnBlcok?
    func  callClosure(close : choicePersonBtnBlcok?){
        choicePersonBtnArrayBlcok = close
    }
    var choicePersonBtnArray = [OrderUserVo]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        navigationItem.title = "选择接单人"
        tableView.backgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        tableView.registerClass(oderTypeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = UIColor.init(rIn255: 29, gIn255: 28, bIn255: 32)
        tableView.rowHeight = 77
        tableView.registerNib(UINib(nibName: "contantsTableViewCell", bundle: nil), forCellReuseIdentifier: "contactCell")
        tableView.sectionIndexColor = UIColor.init(rIn255: 123, gIn255: 132, bIn255: 139)
        tableView.sectionIndexBackgroundColor = UIColor.init(rIn255: 39, gIn255: 44, bIn255: 48)
        
        request = AECOrderRightApiManager(urlProvider: self)
        request!.apiCallBackDelegate = self
        request!.loadData()
        
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let btn = UIButton()
        btn.setImage(UIImage(named:"scada_iconNavBack" ), forState: .Normal)
        btn.setImage(UIImage(named:"scada_iconNavBack" ), forState: .Highlighted)
        btn.bounds = CGRectMake(0, 0, 44, 44)
        btn.addTarget(self, action: #selector(PaiDanViewController.popBackViewCotroller), forControlEvents: .TouchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if choicePersonBtnArrayBlcok != nil {
            
            choicePersonBtnArrayBlcok!(choicePersonBtnArray)
            
        }
    }
    func popBackViewCotroller(){
        
        if choicePersonBtnArrayBlcok != nil {
            choicePersonBtnArrayBlcok!(choicePersonBtnArray)
        }
        navigationController!.popViewControllerAnimated(true)
        self.hidesBottomBarWhenPushed = false
    }
    deinit  {
        print("PaiDan ---deinit")
    }
    
    
    func managerCallAPIDidSuccess(manager: AECApiBaseManager) {
        
        if manager is AECOrderRightApiManager {
            let responseDic = request!.ResponseRawData as? NSDictionary
            switch ((responseDic!["result"]) as? String)
            {
            case "success"?:
                
                var dataMArray : [Dictionary<String,AnyObject>]
                dataMArray = responseDic!["receiveUsers"] as! [Dictionary<String,AnyObject>]
                self.dataMutableArray.removeAll()
                self.titleArray.removeAll()
                for dataA in dataMArray{
                    let paid = OrderUserVo.paiDan(dataA)
                    self.dataMutableArray.append(paid)
                    
                }
                titleArray = getFirstWord(self.dataMutableArray)
                tableView.reloadData()
                
            default: break
            }
        }
        
    }
    
    var firstN = [String]()
    var lastW :String?
    func getFirstWord(OrderUserVo1 : [OrderUserVo]) -> [[String : [OrderUserVo]]] {
        dataSortArray.removeAll()
        var dicArray = [[String : [OrderUserVo]]]()
        let sortArray = getSortArray(OrderUserVo1)
        
        for (i,strF) in sortArray.enumerate() {
            let str =  chineseArrayToPinYinArray(strF.userName!) as NSString
            let firstW = str.substringToIndex(1).uppercaseString
            sortArray[i].section = firstW
        }
        
        for index in 0..<sortArray.count{
            for index0 in index..<sortArray.count{
                
                if sortArray[index].section == sortArray[(index0 + 1)%(sortArray.count - 1)].section{
                    
                    if firstN.contains(sortArray[index].section!) == false{
                        firstN.append(sortArray[index].section!)
                        
                    }
                }
                
            }
            
        }
        
        
        for sort in sortArray{
            if firstN.contains(sort.section!) == false{
                firstN.append(sort.section!)
            }
        }
        debugPrint(firstN,"++")
        
        
        for word in firstN{
            var sectionArray = [OrderUserVo]()
            for sort in sortArray{
                if word == sort.section{
                    sectionArray.append(sort)
                }
            }
            
            dicArray.append([word : sectionArray])
            
        }
        return dicArray
    }
    
    func getSortArray(str : [OrderUserVo]) ->[OrderUserVo]  {
        
        
        let strMutable = str.sort { (str1:OrderUserVo, str2:OrderUserVo) -> Bool in
            return sortTitles(chineseArrayToPinYinArray(str1.userName!), str2: chineseArrayToPinYinArray(str2.userName!))
        }
        return strMutable
    }
    
    
    func chineseArrayToPinYinArray(str : String)->String{
        
        let str1 = NSMutableString(string: str) as CFMutableStringRef
        CFStringTransform(str1,nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str1,nil, kCFStringTransformStripDiacritics,false)
        
        return str1 as String
    }
    
    func sortTitles(str1:String,str2:String)->Bool{
        guard str1 != "" else{return false}
        guard str2 != "" else{return true}
        let strl = (str1 as NSString).substringToIndex(1).uppercaseString
        let strn = (str2 as NSString).substringToIndex(1).uppercaseString
        if (strl < "A")&&(strn < "A"){
            return str1 < str2
        }
        
        let strT1 = judgeAZ(strl)
        let strT2 = judgeAZ(strn)
        
        return strT1 < strT2
    }
    
    
    func judgeAZ(str:String)->String{
        if str.substringToIndex(str.startIndex.advancedBy(1)).uppercaseString < "A"{
            return "["
        }else{return str}
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
        return SignOnViewController.getUrl()! + "/app/receiveUsers.action"
    }
    func parametersForManager(manager: AECApiBaseManager) -> Dictionary<String, AnyObject>? {
        
        return HttpParameterAssembler.assembleParameter(nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return firstN.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let title = titleArray[section][firstN[section]]
        return title!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as!contantsTableViewCell
        let per = titleArray[indexPath.section][firstN[indexPath.section]]
        cell.date = per![indexPath.row]
        
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let backview = UIView()
        backview.backgroundColor = UIColor.init(rIn255: 45, gIn255: 50, bIn255: 56)
        backview.frame = (tableView.cellForRowAtIndexPath(indexPath)?.bounds)!
        tableView.cellForRowAtIndexPath(indexPath)?.selectedBackgroundView =  backview
        
        
        
        let cell =  (tableView.cellForRowAtIndexPath(indexPath) as! contantsTableViewCell)
        cell.choiceBtn.selected = !cell.choiceBtn.selected
        cell.date?.btnStatus = cell.choiceBtn.selected
        if  choicePersonBtnArray.count <= 20{
            if cell.choiceBtn.selected == true && choicePersonBtnArray.contains(cell.date!) == false {
                choicePersonBtnArray.append(cell.date!)
            }
            else if cell.choiceBtn.selected == false && choicePersonBtnArray.contains(cell.date!) == true{
                let choicePersonBtnNSarray = choicePersonBtnArray  as NSArray
                let choicePMutableArray = choicePersonBtnNSarray.mutableCopy()
                choicePMutableArray.removeObject(cell.date!)
                choicePersonBtnArray = choicePMutableArray as! [OrderUserVo]
            }
        }
        for ch in choicePersonBtnArray{
            
            debugPrint(ch.userName)
            debugPrint(ch.btnStatus)
        }
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let btn = UIButton()
        btn.setTitle(firstN[section], forState: .Normal)
        btn.contentHorizontalAlignment = .Left
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        btn.setTitleColor(UIColor.init(rIn255: 184, gIn255: 207, bIn255: 230), forState: .Normal)
        btn.userInteractionEnabled = false
        btn.backgroundColor = UIColor.init(rIn255: 29, gIn255: 28, bIn255: 32)
        
        return btn
    }
    //
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // men hao xiugai
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        return firstN
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let selectedIndex = NSIndexPath(forItem: 0, inSection: index)
        tableView.scrollToRowAtIndexPath(selectedIndex, atScrollPosition: .Top, animated: true)
        return index
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
