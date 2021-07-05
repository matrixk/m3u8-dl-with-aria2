# m3u8-dl-with-aria2

Linux下一个简单的从m3u8下载ts并合并封装的自动脚本，调用aria2进行多线程下载

注：此脚本适用于需要登录才能观看的LIVE流，一般的LIVE流不需要传入cookie

## 使用方法

在目标文件夹中新建一个文档，如`info.txt`，第一行填写`.m3u8`文件的url，第二行填写对应的cookie

```
chmod +x m3u8-dl-with-aria2.sh
./m3u8-dl-with-aria2.sh info.txt
```
