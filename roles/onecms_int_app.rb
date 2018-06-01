name 'onecms_int_app'
description 'One CMS Internal App Server'
run_list 'recipe[onecms::win_int_app_configure]'
