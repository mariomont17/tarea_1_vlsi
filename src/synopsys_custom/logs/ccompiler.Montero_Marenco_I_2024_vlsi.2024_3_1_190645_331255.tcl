gi::createWindow -windowType [gi::getWindowTypes giHomePage]
gi::executeAction giCloseWindow -in [gi::getWindows 2]
db::setAttr iconified -of [gi::getFrames 1] -value true
exit
