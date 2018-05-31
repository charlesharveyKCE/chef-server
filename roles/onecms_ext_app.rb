name "onecms_ext_app"
description "One CMS External App Server"
run_list "recipe[onecms::win_ext_app_configure]"