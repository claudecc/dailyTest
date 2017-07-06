//
//  UIMacro.h
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/6/23.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

#define THEME_COLOR UIColorFromRGB(0xffffff) 

//label
#define LZ_BG_LABEL(_object_name_, _bg_color_,_object_color_,_object_size_,_type_,_lines_,_superView_)\
if(!_object_name_){\
_object_name_ = [[UILabel alloc]init];\
[_object_name_ setBackgroundColor:_bg_color_];\
[_object_name_ setTextColor:_object_color_];\
[_object_name_ setTextAlignment:_type_];\
[_object_name_ setFont:tpFont(_object_size_)];\
[_object_name_ setNumberOfLines:_lines_];\
[_object_name_ setAdjustsFontSizeToFitWidth:YES];\
[_object_name_.layer setCornerRadius:2];\
[_object_name_ setClipsToBounds:YES];\
[_superView_ addSubview:_object_name_];\
}\
return _object_name_;\

//
#define XD_LABEL(_object_name_,_object_color_,_object_size_,_type_,_lines_,_superView_)\
if(!_object_name_){\
_object_name_ = [[UILabel alloc]init];\
[_object_name_ setBackgroundColor:[UIColor clearColor]];\
[_object_name_ setTextColor:_object_color_];\
[_object_name_ setTextAlignment:_type_];\
[_object_name_ setFont:tpFont(_object_size_)];\
[_object_name_ setNumberOfLines:_lines_];\
[_object_name_ setAdjustsFontSizeToFitWidth:YES];\
[_superView_ addSubview:_object_name_];\
}\
return _object_name_;\


#endif /* UIMacro_h */
