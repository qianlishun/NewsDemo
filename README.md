# NewsDemo

####news demo
####效果图
<img src="http://ww4.sinaimg.cn/mw690/e70bae90gw1f53v2ngvlej20hs0vkwlp.jpg" alt="" width="231" height="426" />   <img src="http://ww2.sinaimg.cn/mw690/e70bae90gw1f53v2p2494j20hs0vk772.jpg" alt="" width="231" height="426" />

####简介
* 1. 仿网易新闻app,基本框架完成,可左右滑动切换新闻频道(每个 cell 跳转的是 webview)  
* 2. 修复cell 重用问题 与 排版混乱
* 3. 修复数据重复显示问题
* 4. 解决滑动切换频道重复问题
* 5. 增加频道按钮,可点击,(有 bug)  
  * 修复频道按钮点击后,频道条的滚动问题 
  * 频道点击切换频道基本完成     
* 6. 去除了webView中的顶部广告  
* 7. 优化刷新与数据显示  
* 8. 优化网络请求, 
* 新问题:目前切换视图再返回就会滚到首个数据,collectionView滑动切换 cell 后,如何缓存上一个控制器的滚动的位置,思路有两点:①缓存视图的 offset, 切换回来后setOffset ,② 缓存控制器(耗内存).. ③因为 cell 是重用的,那么 cell 里的tableview 也是重用的,只能采用第一种方法了.创建一个数组缓存 offset 利用 index 与 Item 一一对应....
