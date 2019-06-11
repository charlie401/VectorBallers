//
//  UrlManager.swift
//  AECiPEMS
//
//  Created by henghao.jiao on 2018/12/12.
//  Copyright © 2018年 AEC. All rights reserved.
//

import UIKit

class UrlManager: NSObject {
    public static let URL_USER_REMIND_LIST = "/app/getUserRemindList.action"
    public static let URL_FIND_ALL_OFFLINE_PACKAGE_UPDATE = "/app/findAllOfflinePackageUpdate.action"
    public static let URL_TAKE_ORVER_SEND_OUT_LIST = "/app/listWorkOrder.action"
    public static let URL_CONFIRM_REJECT_WORKORDER = "/app/confirmOrder.action"
    public static let URL_WORKORDER_SEND = "/app/findSendOrderByPage.action"
    public static let URL_ALARMS_FIND_ALL_BY_PAGE = "/app/findAllAlarmByPage.action"
    public static let URL_FINA_ALL_VISUAL_RESOURCES = "/app/findAllScadas.action"
    public static let URL_FIND_AIDI_BY_DEVICE_ID = "/app/findAIAndDIByDeviceId.action"
    public static let URL_REAL_TIME_DATA = "/app/appRealTimeData.action"
    public static let URL_USER_FOCUS_LIST = "/app/userFocusList.action"
    public static let URL_USER_COLLECTION_LIST = "/app/userCollectList.action"
    public static let URL_ADD_USER_COLLECTION = "/app/addUserCollect.action"
    public static let URL_GET_DEVICE_LEVEL = "/app/getDeviceLevel.action"
    public static let URL_GET_ALL_DEVICE_FILTER_LEVEL = "/app/getAllDeviceFilterLevel.action"
    public static let URL_ALARM_LEVEL_FILTER = "/app/alarmLevelFilter.action"
    public static let URL_IS_ORDER_PRIVILEGE = "/app/isOrderPrivilege.action"
    public static let URL_ORDERTYPES = "/app/orderTypes.action"
    public static let URL_SEND_ORDER = "/app/sendOrder.action"
    public static let URL_ALTER_ORDER = "/app/alterOrder.action"
    public static let URL_RECEIVE_USERS = "/app/receiveUsers.action"
    public static let URL_FIND_USER_INFO = "/app/findUserInfo.action"
    public static let URL_UPDATE_PASSWORD = "/app/updatePassword.action"
    public static let URL_UPDATE_USER_INFO = "/app/updateUserInfo.action"
    public static let URL_UPLOAD_PHOTO = "/app/uploadPhoto.action"
    public static let URL_ORDER_DETAIL = "/app/OrderDetail.action"
    public static let URL_REPLY_ORDER = "/app/replyOrder.action"
    public static let URL_RECEIVE_ORDER = "/app/receiveOrder.action"
    public static let URL_USER_INFO_UPDATE = "/app/user/update"
    public static let URL_RESOURCE = "/app/page/getPages"
    public static let URL_LOGIN = "/app/user/login"
    public static let URL_LOGOUT = "/app/user/logout"
    public static let URL_USER_INFO = "/app/user/detail"
    public static let URL_UPDATE_TOKEN = "/app/updateToken.action"
    public static let URL_FIND_ALARMS_BY_DEVICE_ID = "/app/findAlarmsByDeviceId.action"
    public static let URL_ALARMDETAIL = "/app/alarmDetail.action"
    public static let URL_CONFIRM_ALARM = "/app/judgeAlarm"
    public static let URL_ADD_USER_REMIND = "/app/uploadUserRemindIds.action"
    public static let URL_WORKORDER_RECEIVE = "/app/findReceiveOrderByPage.action"
    public static let URL_FIND_ALL_DEVICES = "/app/getUserDeviceList.action"
    public static let URL_FIND_FOCUS_DEVICES = "/app/getUserFocusDeviceList.action"
    public static let URL_GET_FOCUS_VISUAL_RESOURCES = "/app/getUserFocusReportList.action"
    public static let URL_ADD_DEVICES_FOCUS = "/app/uploadDeviceFocusList.action";
    public static let URL_UPLOAD_VISUAL_RESOURCES = "/app/uploadReportFocusList.action";
    public static let URL_FIND_DEVICE_VISUAL_RESOURCES_SUB_SYSTEMS = "/app/getSubsystem";

}
