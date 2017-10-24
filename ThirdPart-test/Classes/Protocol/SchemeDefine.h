//
//  SchemeDefine.h
//  MasterDuoBao
//
//  Created by 汤丹峰 on 16/3/23.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#ifndef SchemeDefine_h
#define SchemeDefine_h

//自定义协议头
#define URL_SCHEME          @"honglu"
//自定义域名
#define URL_HOST            @"www.honglu.com"


//协议中的path标记
#define URL_PATH_WEB        @"/jump"        //跳H5
#define URL_PATH_NATIVE     @"/native"      //跳本地controller
#define URL_PATH_SHARE      @"/share"       //H5发出的分享
#define URL_PATH_CLOSR      @"/close"       //关闭当前控制器
#define URL_PATH_NATIVENEW  @"/native_new"  //跳本地二级或更深级controller
#define URL_PATH_WXGUANZHU  @"/wx_guanzhu"  //WX关注


//协议中query的参数KEY
#define URL_QUERY_KEY_NAME                  @"name"
#define URL_QUERY_KEY_TITLE             @"title"
#define URL_QUERY_KEY_TYPE              @"type"
#define URL_QUERY_KEY_INDEX             @"index"        //name=home时参数 第几个tab页面
#define URL_QUERY_KEY_TARGETURL         @"target_url"   //name=recharge时参数，充值成功后跳转用
#define URL_QUERY_KEY_UID               @"uid"          //name=personal_page时参数
#define URL_QUERY_KEY_CANBACK           @"can_go_back"

#define URL_QUERY_KEY_URL               @"url"          //网页时传输下面四个参数
#define URL_QUERY_KEY_NAV               @"nav"
#define URL_QUERY_KEY_RIGHTBTNTITLE     @"right_btn_title"  //网页右上角按钮，可放刷新、分享、跳转等按钮
#define URL_QUERY_KEY_DISPLAY           @"display"

#define URL_QUERY_KEY_SHAREPAGETYPE     @"share_page_type"  //share协议带的参数
#define URL_QUERY_KEY_PAGETYPEID        @"page_type_id"
#define URL_QUERY_KEY_IMG               @"img"
#define URL_QUERY_KEY_CONTENT           @"content"
#define URL_QUERY_KEY_SHAREURL          @"share_url"
#define URL_QUERY_KEY_TYPES             @"types"
#define URL_QUERY_KEY_ISSHOWIMAGE       @"is_share_image"



//约定好的native界面名称参数值
#define VC_HOME             @"home"                 //主界面

#endif /* SchemeDefine_h */
