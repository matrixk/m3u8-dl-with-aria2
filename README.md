# m3u8-dl-with-aria2
Linux下一个简单的从m3u8下载ts并合并封装的自动脚本

注：此脚本适用于需要登录才能下载的LIVE流

## 使用方法

在目标文件夹中新建一个文档，如`info.txt`，第一行填写`.m3u8`文件的url，第二行填写对应的cookie

```
chmod +x m3u8-dl-with-aria2.sh
./m3u8-dl-with-aria2.sh info.txt
```
