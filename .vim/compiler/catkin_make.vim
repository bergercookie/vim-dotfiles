let current_compiler="catkin_make"

" TODO - Currently you explicitly have to specify the path to the workspace
" TODO - use-ninja via var
setlocal makeprg=catkin_make\ -C\ ~/slamcore/ros_ws\ --use-ninja\ --cmake-args\ -DCMAKE_BUILD_TYPE=RelWithDebInfo
setlocal errorformat=%f:%l:%c:\ error:\ %m
setlocal errorformat+=%f:%l:%c:\ note:\ %m

