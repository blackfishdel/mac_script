


#通过全新界面的DiskUtility抹掉， 确保U盘和外置硬盘使用的分区方式为：GUID，
#格式为：Mac日志式，分区名称：MyVolume （大小写要注意）
#

sudo '/Applications/Install macOS High Sierra.app/Contents/Resources/createinstallmedia' \
--volume /Volumes/MyVolume --applicationpath '/Applications/Install macOS High Sierra.app'

#终端会显示进度条，只要看到“Done”的字样，代表已经创建成功！
