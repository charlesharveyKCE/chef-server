name "onecms_int_web"
description "One CMS Internal Web Server"
run_list "recipe[onecms::win_int_web_configure]"
