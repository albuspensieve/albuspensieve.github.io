---
title: 博客重装修，单车变摩托（1）：Jekyll 再见，Hexo 你好
date: 2024-06-17 15:46:35
tags: coding
og_img: 2024/06/17/2024-06-17-blogfurnish/thumbnail.png
category: 博客装修
---

最近一件大事是重新装修了博客～上一回装修博客已经是 2018 年的事情了，当时是因为实在无法接受 Lofter 的审核，于是萌生了自己建站的想法。当时选择的方法是 Jekyll + Github Pages，也是花了挺大力气才弄好的。 2021年听说 Jekyll 的代码基本处于冻结状态了（？除了 bug fix 以外？）就萌生了换一个引擎的想法。正好前段时间为我们「女巫茶话会」播客做网页使用了 Hexo，体验还不错，就打算试试把个人博客也换成 Hexo。网上 Hexo 的教程满天飞，这里就不重复了，就只记录一些个人迁移过程中「印象比较深刻」（i.e. 花了不少时间）的点😅主要是怕自己之后忘了😂

<figure>
<img src="old_blog.png" width="70%"/>
<figcaption>先纪念一下使用了6年的前博客！🙏</figcaption>
</figure>

## 选择主题
作为一个前端半吊子，不，十分之一吊子，我还是很依赖搭建好的主题的哈哈哈～我上一个博客也是用的别人的主题，但是感觉它的文档和维护都没有做得很好，所以前期花了很长时间搞明白怎么使用。所以这次想找一个有很好的文档以及维护相对活跃的主题。找来找去发现一个满足我的要求而且也很合眼缘的主题 [Fluid](https://github.com/fluid-dev/hexo-theme-fluid)，尤其喜欢标题的打字机效果🤣这个主题专门有[文档网站](https://hexo.fluid-dev.com/docs/start/)可以了解怎么安装，怎么配置，还介绍了一些进阶用法。而且这个主题里面包含的功能很多，如果不想自己折腾源码的话直接拿来用也可以满足大部分的需求～

个性化基本上只需要按照[配置指南](https://hexo.fluid-dev.com/docs/guide/#关于指南)修改`_config.fluid.yml`即可，什么标题呀，颜色呀，题图呀，字体呀，导航栏呀，应有尽有～

Fluid 主题的文档做得很好，而且也包含了很多关于 hexo 的知识，所以我在搭建过程中主要就是靠他们的文档。不过Hexo 的[官方文档](https://hexo.io/docs/)也写的蛮好的，而且貌似因为 Hexo 社区很大一部分是中国人，中文版本做得也挺好，比较基础的问题可以参考官方文档～

<figure>
<img src="fluid.png" width="70%"/>
<figcaption>Fluid 主题 Demo</figcaption>
</figure>

## Deployment 小状况
我在做「女巫茶话会」网站的时候使用的是 [One-Command Deployment](https://hexo.io/docs/one-command-deployment) 即`hexo deploy` 直接进行deployment，结果尝试 deploy 这个博客的时候不知道为什么 hexo 就认准了女巫茶话会的 github 账号，尝试了各种手段它都不认我的个人账号，就没权限往我自己的 github push 代码🫠无奈之下发现还有一种 deployment 方式是使用 [Github Actions](https://hexo.io/docs/github-pages)，尝试了一下终于成功了！`hexo deploy` 的原理是把本地生成的静态网页们 push 到 github repo 里，源码是保存在本地的（或者什么你喜欢的别的地方），而使用 github actions 的话会把整个源码 push 上去，trigger github actions 来生成静态网页们。个人觉得这个流程也更符合自己的习惯一些，不过缺点就是源码会被 push 到 github repo上。

## 图片脚注
这个可能是比较 hacky 的做法😂谁让我就是经常在 markdown 里写 html 的选手呢哈哈哈～目前使用如下方法为图片添加脚注。出来的效果个人还挺满意的～

```html
<figure>
<img src=[img_source] width="50%"/>
<figcaption>[Your awesome caption]</figcaption>
</figure>
```

<figure>
<img src="https://media.giphy.com/media/AOrThUuuOoDCg/giphy.gif?cid=790b7611t1cawu6guufkytgd3n4zzyy2tlv2i0jhs2my3szi&ep=v1_gifs_search&rid=giphy.gif&ct=g" width="50%"/>
<figcaption>卖个萌～</figcaption>
</figure>

## 插入视频
由于我个人的习惯，文章里还挺经常出现视频的，主要是 youtube 视频，也有一些本地视频和 B 站视频。

### Youtube 视频
Hexo 有非常多的可以用于插入 youtube 的插件，因为我使用官方 `hexo-tag-embed` 插入视频的大小不是 responsive的，最后我选择的是 [`hexo-tag-youtube-responsive`](https://github.com/quocvu/hexo-tag-youtube-responsive)。使用下面的代码就可以插入视频：

```markdown
{% youtuber video [videoId] %}
{% endyoutuber %}
```

### 本地视频
我有个别的过去的博客文章有本地视频，很奇怪的是我之前使用的插入本地视频的 html 代码来在 Chrome 和 Firefox 都显示得很好，但是在 Mac 的 Safari 怎么都显示不出来😂在网上搜了一下貌似这是 Safari 的一个[问题](https://stackoverflow.com/questions/20347352/html5-video-tag-not-working-in-safari-iphone-and-ipad)？可惜尝试了网上说的方法在我这也行不通🤷‍♀️后来有网友建议把视频上传到 Youtube 后再下载下来试试，尝试之后还是不行，但是发现 unlisted 的 Youtube 视频也可以被正确引用，于是就决定把他们放到 Youtube 上好了😂也节省一些本地空间～

### Bilibili 视频
B 站视频还是使用 good old iframe 进行插入
```html
<iframe src="//player.bilibili.com/player.html?aid=[your_aid]]&bvid=[your_bid]&cid=[your_cid]&page=1&autoplay=0" 
    scrolling="no" 
    border="0" 
    frameborder="no" 
    framespacing="0" 
    allowfullscreen="true" 
    width="100%" 
    height="400"
> 
</iframe>
```

### Instagram 视频
我在一篇文章里面有 Instagram 视频，最后使用了 [`hexo-tag-instagram`](https://github.com/tea3/hexo-tag-instagram)插件。语法是
```markdown
{% instagram [insId] %}
```

## 折叠块
有时候写书评会想把一些剧透部分折叠起来，很开心的是 Fluid 主题自带了这个[功能](https://hexo.fluid-dev.com/docs/guide/#tag-%E6%8F%92%E4%BB%B6)！
```markdown
{% fold info @title %}
需要折叠的一段内容
{% endfold %}
```
{% fold info @打开看看不？ %}
如果你打开了这个折叠块，祝你生活愉快🤗
{% endfold %}

## Disqus 评论迁移
因为之前 Jekyll 生成的文章链接格式和 Hexo 的不太一样，于是我需要迁移之前的 Disqus 评论（其实我也可以改 hexo 文章链接格式的，但是不知道怎么回事当时就没想到这一点😅）。好在 Disqus 有一个 [Migration tool](https://help.disqus.com/en/articles/1717068-migration-tools)，其中的 URL Mapper 正好符合我的需求～只需要准备一个 csv file，第一列是之前的文章链接，第二列是更新的文章链接，提交就可以啦～

至此博客重装修的基本配置就已经完成啦，下一篇会简要介绍一下我之后的一些「无用折腾」，包括添加 Channel Talk「客服」，添加「随机游走」入口🔀，添加「最近咋样」页面以及博客热力图🎉～
