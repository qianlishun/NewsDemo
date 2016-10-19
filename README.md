# NewsDemo

####效果图
<img src="http://ww4.sinaimg.cn/mw690/e70bae90gw1f53v2ngvlej20hs0vkwlp.jpg" alt="" width="231" height="426" />   <img src="http://ww3.sinaimg.cn/mw690/e70bae90gw1f67i10814tj20hc0v40ur.jpg" alt="" width="231" height="426" />

####简介
* 整体框架为UIcollectionView + UITableView ,
* 根控制器为UICollectionViewController,子界面为在collectionViewCell里加载tableView
* tableView里的cell根据数据的不同去选择加载对应类型的cell
* 使用第三方框架：AFNetiworking,SDWebImage,SDAutoLayout,MJRefresh,SDCycleScrollView...
* 这个 demo 算是 UIcollectionView + UITableView + UIScrollView 的嵌套实现了吧。
* 断网的数据缓存还没有做...

####日志
* 1. 仿网易新闻app,基本框架完成,可左右滑动切换新闻频道(每个 cell 跳转的是 webview)  
* 2. 修复cell 重用问题 与 排版混乱
* 3. 修复数据重复显示问题
* 4. 解决滑动切换频道重复问题
* 5. 增加频道按钮,可点击 
  * 修复频道按钮点击后,频道条的滚动问题 
  * 频道点击切换频道基本完成     
* 6. 去除了webView中的顶部广告  
* 7. 优化刷新与数据显示  
* 8. 优化网络请求, 
* 9.新问题:目前切换视图再返回就会滚到首个数据,collectionView滑动切换 cell 后,如何缓存上一个控制器的滚动的位置
  * 该问题已解决...翻看以前代码和重新思考后发现,想多了... collecttionView本身就可以记录 cell 里 tableView的位置,只是因为 为了优化内存与速度,cell 是重用的 ,每次加载之前我做了一次刷新处理,导致每次切换控制器初始位置都在顶部
  * 解决:  建立一个可变字典作为数据缓存池,以 url 为 key 存储数组, 每次加载作此判断,如果对应数组有数据那么不做刷新和加载操作!
* 10.下一步目标,刷新时,新数据的插入到旧数据之前, 不过因为网易新闻没有该接口,只能在数据上做文章.
* --最近在做蓝牙 SDK, 该 Demo 无限延期...
 
