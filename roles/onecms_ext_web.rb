name "onecms_ext_web"
description "One CMS External Web Server"
run_list "recipe[onecms::win_ext_web_configure]"