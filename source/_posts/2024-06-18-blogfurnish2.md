---
title: 博客重装修，单车变摩托（2）：无用折腾，「肝」之如饴🤣
date: 2024-06-18 17:27:35
tags: coding
og_img: 2024/06/17/2024-06-17-blogfurnish/thumbnail.png
category: 博客装修
---

在花了很大功夫终于完成了基础装修之后，我这不安的心又起了折腾的念头，主要是因为香油的博客们都太好看了哈哈哈～于是我添加了以下的加花儿功能：Channel Talk 「客服」，「最近咋样」页面，「随机游走」功能以及个人最喜欢的热力图🎉

# 添加 Channel Talk 「客服」
在友邻的博客[第三夏尔](https://thirdshire.com/hugo-stack-renovation/#私信联系气泡)发现了 Channel Talk 这个东西，觉得好好玩～ 这个东西类似于网页客服，有免费版，而且安装挺简单的～
1. [官网](https://channel.io/en)注册账号
2. 注册登录后找到页面左下方的齿轮进入设置，之后点击 General -> Manage Plug-in，在 Install plug-in for web 找到 JavaScript 代码
3. 把这段 JavaScript 代码放到你想要的地方就可以啦～

# 添加「最近咋样」页面和「随机游走」功能
## 「最近咋样」
`fluid` 主题官方文档里有自定义页面的[教程](https://hexo.fluid-dev.com/docs/guide/#自定义页面)，基本上跟着这个做就可以了～目前是一个很简单的 markdown 文件，日后考虑是不是可以弄成时间轴的样式之类的（又给自己挖坑了哈哈哈哈哈

## 「随机游走」
在[椒盐豆豉](https://blog.douchi.space)的博客上看到了这个「随便看看」功能，觉得很有意思，感觉也可以方便自己回顾一下之前的博客文章～「随机游走」的核心就是随机的抽一个博客文章出来，在 hexo 的 ejs 里可以使用 `site.posts.random().limit(1)` 随机摇一篇文章出来。

## 添加入口
接下来的任务就是添加「最近咋样」和「随机游走」的入口。我想把它们放在 banner 的大图上，每一个页面都可以 access，类似于一个二级导航栏的感觉。在源码中找了半天发现 banner 的配置主要是在 `fluid/layout/_partial/header/banner.ejs`里。因为实现的是一个非常类似于 navigation bar 的功能，于是我对着 `fluid/layout/_partial/header/navigation.ejs` 有样学样 🤣

navigation 的主要结构就是一个 `<ul>` 里面放着很多 `<li>`, 第一个 「随机游走的」`<li>` 的代码如下，应该还是比较好理解的，就是摇出一个随机的 post 之后获取它的 url 放在 `<a>` 里，再找一个自己喜欢的 font awesome icon 放在 `<i>` 里，最后放上「随机游走」四个大字。

```javascript
<% site.posts.random().limit(1).each(function(post){ %>
    <li>
      <a class="nav-link" style="color: white" href="<%- url_for(post.path) %>">
      <i class="fa-solid fa-shuffle"></i><span> 随机游走</span></a>
    </li>
<% }) %>
```

对于「最近咋样」页面也可以按以上方式处理，但我想更 general 一些。万一以后我还想要添加别的 item，如果可以直接在 `config.yml` 里写，而不是每次都需要修改深层的 `ejs`会更方便一些～于是我在最外层的 `_config.fluid.yml` 中添加了

```yml
banner_nav:
  menu:
    - { key: "最近怎样", link: "/recent/", icon: "fa-solid fa-hands-clapping" }
```

这样在 `ejs` 里我们就可以为每一个 menu 下的 item 写自己的 `<li>`，代码如下

```javascript
<% for(const each of theme.banner_nav.menu || []) { %>
       <% if (!each.link) continue %>
       <% var text = each.key %>
       <li>
         <a class="nav-link" style="color: white" href="<%= url_for(each.link) %>">
         <%- each.icon ? '<i class="' + each.icon + '"></i>' : '' %>
         <span><%- text %></span>
         </a>
       </li>
       <% } 
%>
```

综合上面两个代码，再套上 nav 的壳即可得完整代码
{% fold info @完整代码 %}
```javascript 
<nav class="navbar navbar-expand-lg justify-content-center">
    <ul class="navbar-nav">
    <% site.posts.random().limit(1).each(function(post){ %>
        <li>
           <a class="nav-link" style="color: white" href="<%- url_for(post.path) %>">
           <i class="fa-solid fa-shuffle"></i><span> 随机游走</span></a>
        </li>
      <% }) 
    %>
    <% for(const each of theme.banner_nav.menu || []) { %>
       <% if (!each.link) continue %>
       <% var text = each.key %>
       <li>
           <a class="nav-link" style="color: white" href="<%= url_for(each.link) %>">
           <%- each.icon ? '<i class="' + each.icon + '"></i>' : '' %>
           <span><%- text %></span></a>
       </li>
       <% } 
     %>
    </ul>
</nav>
```
{% endfold %}

# 热力图
最后一个实现的功能是热力图功能，灵感也是来自[椒盐豆豉](https://blog.douchi.space)博客。椒老师之前发过一篇[文章](https://blog.douchi.space/hugo-blog-heatmap)是将如何在 Hugo 里使用 echarts 绘制热力图。热力图真的看起来好酷，而且感觉也可以激励自己多发博客（？真的吗🤨可惜我的架构是 Hexo，没法直接复制粘贴，但是基本原理是类似的。

## 绕弯路
一开始在椒老师这篇博客的评论区发现了有人使用 Hexo 制作热力图，于是就跑过去学习。TA 是用 d3 做的，鼓捣了半天我突然意识到这不是我想要的东西，因为 TA 只是画了从今天倒数 45 x 8 个格子，并没有附带日历的功能。而且生成的热力图不知道为什么大小并不 responsive，于是我又回到了 echarts 的怀抱😂

## 基本原理
Echarts 里面有一个绘制日历的功能，比如在官方案例中有一个展示每日步数的[例子](https://echarts.apache.org/examples/en/editor.html?c=calendar-heatmap)，效果如下图

<figure>
<img src="dailystep.png" width="70%"/>
<figcaption>Echarts 官方的 Daily Step Heatmap 效果图</figcaption>
</figure>

博客文章的热力图和这个是一个原理，只不过数据是每天博客文章的字数。于是想要绘制这个图有两步，第一步是获取数据，第二步是使用 Echarts 把数据可视化出来。不过在这之前首先需要了解如何在 Hexo 中插入 Echarts～

## Hexo 里添加 Echarts
Hexo 添加 Echarts 不是非常的 straightforward，我找了半天发现了一篇[博客文章](https://blog.eurkon.com/post/1213ef82.html)看起来有我想要的东西～

研究了这篇博客的源码之后了解到需要把绘制 Echarts 的代码放到一个 `js`文件中。这个文件的核心是生成一段包含如何画这个图的 `html`代码。然后使用 `hexo.extend.filter.register`把生成的 `html` 可以由其他页面调用（具体原理我不是很了解，我只是有样学样😂）。以下是我的 `heatmap.js` 里过滤器的代码，其中`postsCharts` 就是对应着绘制的核心函数。

```javascript
hexo.extend.filter.register('after_render:html', function (locals) {
  const $ = cheerio.load(locals)
  const post = $('#posts-chart')
  const htmlEncode = false
  if (post.length > 0) {
    if (post.length > 0 && $('#postsChart').length === 0) {
      if (post.attr('data-encode') === 'true') htmlEncode = true
      post.after(postsChart())
    }
    if (htmlEncode) {
      return $.root().html().replace(/&amp;#/g, '&#')
    } else {
      return $.root().html()
    }
  } else {
    return locals
  }
}, 15)
```
## `postCharts`函数
下一步就是写 `postCharts` 函数生成 Echarts了。如前所述这个函数包含 1）获取数据 2）画图两步。我们想实现的功能是字数越多，当天的格子颜色就越深，另外鼠标悬停到每个格子上的时候可以显示文章标题和字数，鼠标点击格子的时候可以跳转到相应的文章页面。

### 获取数据
获取的数据其实就是所有的博客文章的日期，标题，字数和链接。Hexo提供了 `hexo.locals.get('posts')`函数我把它们存在 `postArr` 中。另外因为 Echarts 的 Calendar 图表对应的数据就是`[[日期，标题]]`，我把这两个数据提出来存在 `dataArr`中～

```javascript
const postArr = [];
const dataArr = [];
hexo.locals.get('posts').map(function (post) {
postArr.push({ title: post.title,
               date: post.date.format('YYYY-MM-DD'),
               wordcount: (getWordCount(post.content)/1000).toFixed(2),
               path: post.path })
dataArr.push([post.date.format('YYYY-MM-DD'), getWordCount(post.content)/1000])})
```

其中 `getWordCount` 函数如下

```javascript
const { stripHTML } = require('hexo-util');
function getWordCount(contentString){
  const content = stripHTML(String(contentString)).replace(/\r?\n|\r/g, '').replace(/\s+/g, '');
  const zhCount = (content.match(/[\u4E00-\u9FA5]/g) || []).length;
  const enCount = (content.replace(/[\u4E00-\u9FA5]/g, '').match(/[a-zA-Z0-9_\u0392-\u03c9\u0400-\u04FF]+|[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af\u0400-\u04FF]+|[\u00E4\u00C4\u00E5\u00C5\u00F6\u00D6]+|\w+/g) || []).length;
  wordcount = zhCount + enCount
  return wordcount;
};
```

以上两个 array 由于需要被传到 `html` string 里，所以需要使用 `JSON.stringify`

```javascript
var dataCalendar = JSON.stringify(dataArr)
var dataPosts = JSON.stringify(postArr)
```

### 使用 Echarts 画图
Echarts 的部分我基本上是照抄了椒盐豆豉老师的配置～唯一的不同是椒老师是直接在外面 build 一个 `dataMap`，这样根据每个日期都可以找到当天发布的文章信息。我一开始也这么做，结果发现这个玩意没法被传到要被 return 的`html` string里，于是我选择了在这个 `html` string里再根据 `dataPosts` 来创建 `dataMap`的方法。

```html
let dataPosts = ${dataPosts}
const dataMap = new Map(dataPosts.map((obj) => [obj.date, {title: obj.title, wordCount: obj.wordcount, path: obj.path}]));
```

剩下的代码基本上就和椒老师是一样的了，除了一些颜色设置不同，以及我挺喜欢 Echarts calendar里的月份分割线的，就把它加回来了～

### 适配暗黑模式
我的博客有暗黑模式的支持，好不容易画好了这个图，尝试换到夜间模式却瞬间闪瞎狗眼，然后标题啥的也都看不见了，所以适配暗黑模式还是必要的。Echarts 有很多主题，其中就有 `light` 和 `dark` 两个主题，基本符合我的需求。一开始我以为我只需要判断现在是白天模式还是暗黑模式，然后选择相应的主题就可以了。但后来意识到这只能保证如果初始状态是白天模式，主题是 `light`，如果初始状态是黑夜模式，主题是`dark`，但是从白天模式切换为黑夜模式并不会变配色🙈 这是因为 Echarts 生成好之后就不会动了，如果想切换模式就换一个配色就得 1）抓到模式切换的event 2）把之前生成的 Echarts 扔掉 3）根据当前模式再生成一个 Echarts。

抓到模式切换的 event 我用的是如果检测`click`了，我就来判断当前是暗黑模式还是白天模式，然后扔掉当前的 Echarts，根据对应的模式再生成一遍。代码如下：

```javascript
document.body.addEventListener('click', function(e) {
        if (document.documentElement.getAttribute('data-user-color-scheme')==='dark') {
            postsChart.dispose();
            postsChart = echarts.init(document.getElementById('posts-chart'), 'dark');
            postsChart.setOption(postsOption);
            postsChart.on('click', function(params) {
                  const post = dataMap.get(params.data[0]);
                  const link = window.location.origin + "/" + post.path;
                  window.open(link, '_blank').focus();
            });
        } else {
            postsChart.dispose();
            postsChart = echarts.init(document.getElementById('posts-chart'), 'light');
            postsChart.setOption(postsOption);
            postsChart.on('click', function(params) {
              const post = dataMap.get(params.data[0]);
              const link = window.location.origin + "/" + post.path;
              window.open(link, '_blank').focus();
            });
}
```
其实理论上还可以更优化的，比如 filter click 的类型，但是我有点懒就没搞了🙈

## 完整 `heatmap.js` 代码
下面是 `heatmap.js` 的完整代码，它被放在 `fluid/scripts/helpers` 下。
{% fold info @完整代码 %}
```javascript
const cheerio = require('cheerio')
const moment = require('moment')
const { stripHTML } = require('hexo-util');

hexo.extend.filter.register('after_render:html', function (locals) {
  const $ = cheerio.load(locals)
  const post = $('#posts-chart')
  const htmlEncode = false

  if (post.length > 0) {
    if (post.length > 0 && $('#postsChart').length === 0) {
      if (post.attr('data-encode') === 'true') htmlEncode = true
      post.after(postsChart())
    }

    if (htmlEncode) {
      return $.root().html().replace(/&amp;#/g, '&#')
    } else {
      return $.root().html()
    }
  } else {
    return locals
  }
}, 15)

function getWordCount(contentString){
  // post.origin is the original post content of hexo-blog-encrypt
  const content = stripHTML(String(contentString)).replace(/\r?\n|\r/g, '').replace(/\s+/g, '');
  const zhCount = (content.match(/[\u4E00-\u9FA5]/g) || []).length;
  const enCount = (content.replace(/[\u4E00-\u9FA5]/g, '').match(/[a-zA-Z0-9_\u0392-\u03c9\u0400-\u04FF]+|[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af\u0400-\u04FF]+|[\u00E4\u00C4\u00E5\u00C5\u00F6\u00D6]+|\w+/g) || []).length;
  wordcount = zhCount + enCount
  return wordcount;
};

function postsChart () {
    const postArr = [];
    const dataArr = [];
    hexo.locals.get('posts').map(function (post) {
    postArr.push({ title: post.title,
                   date: post.date.format('YYYY-MM-DD'),
                   wordcount: (getWordCount(post.content)/1000).toFixed(2),
                   path: post.path })
    dataArr.push([post.date.format('YYYY-MM-DD'), getWordCount(post.content)/1000])
                })

    var dataCalendar = JSON.stringify(dataArr)
    var dataPosts = JSON.stringify(postArr)

  return `
  <script id="postsChart" type="text/javascript">
    var postsChart = echarts.init(document.getElementById('posts-chart'), document.documentElement.getAttribute('data-user-color-scheme'));
    window.onresize = function() {
      postsChart.resize();
      };
    let dataPosts = ${dataPosts}
    const dataMap = new Map(dataPosts.map((obj) => [obj.date, {title: obj.title, wordCount: obj.wordcount, path: obj.path}]));

    function heatmap_width(months){
        var startDate = new Date();
        var mill = startDate.setMonth((startDate.getMonth() - months));
        var endDate = +new Date();
        startDate = +new Date(mill);
        endDate = echarts.format.formatTime('yyyy-MM-dd', endDate);
        startDate = echarts.format.formatTime('yyyy-MM-dd', startDate);
        var showmonth = [];
        showmonth.push([
            startDate,
            endDate
        ]);
        return showmonth
    };

    function getRangeArr() {
        const windowWidth = window.innerWidth;
        if (windowWidth >= 600) {
          return heatmap_width(12);
        }
        else if (windowWidth >= 400) {
          return heatmap_width(9);
        }
        else {
          return heatmap_width(6);
        }
    }

    var postsOption = {
    title: {
        top: 0,
        left: 'center',
        text: '博客热力图'
    },
    tooltip: {
      formatter: function (p) {
        const post = dataMap.get(p.data[0]);
        return post.title + ' | ' + post.wordCount + ' 千字';
      }
    },
    visualMap: {
        min: 0,
        max: 10,
        type: 'piecewise',
        orient: 'horizontal',
        left: 'center',
        top: 30,
        inRange: {
          //  [floor color, ceiling color]
          color: ['#c0b5c8', '#746184' ]
        },
        splitNumber: 4,
        text: ['千字', ''],
        showLabel: true,
        itemGap: 20,
    },
    calendar: {
        top: 80,
        left: 20,
        right: 4,
        cellSize: ['auto', 12],
        range: getRangeArr(),
        itemStyle: {
            color: '#F1F1F1',
            borderWidth: 2.5,
            borderColor: '#fff',
        },
        yearLabel: { show: false },
        // the splitline between months
        splitLine: {
          lineStyle: {
            color: "#000",
            width: 1,
            type: "solid",
          }
        }
    },
    series: {
        type: 'heatmap',
        coordinateSystem: 'calendar',
        data: ${dataCalendar}
    }
  };

    postsChart.setOption(postsOption);
    window.addEventListener('resize', () => {
      postsChart.resize();
    });
    postsChart.on('click', function(params) {
      const post = dataMap.get(params.data[0]);
      const link = window.location.origin + "/" + post.path;
      window.open(link, '_blank').focus();
});
    document.body.addEventListener('click', function(e) {
        if (document.documentElement.getAttribute('data-user-color-scheme')==='dark') {
            postsChart.dispose();
            postsChart = echarts.init(document.getElementById('posts-chart'), 'dark');
            postsChart.setOption(postsOption);
            postsChart.on('click', function(params) {
                  const post = dataMap.get(params.data[0]);
                  const link = window.location.origin + "/" + post.path;
                  window.open(link, '_blank').focus();
            });
        } else {
            postsChart.dispose();
            postsChart = echarts.init(document.getElementById('posts-chart'), 'light');
            postsChart.setOption(postsOption);
            postsChart.on('click', function(params) {
              const post = dataMap.get(params.data[0]);
              const link = window.location.origin + "/" + post.path;
              window.open(link, '_blank').focus();
        });
        }
    });
  </script>`
}
```
{% endfold %}

## 在页面上添加热力图
因为我想在主页上展示这个热力图，于是我就在 `fluid/layout/index.ejs`中添加了下面两行代码
```markdown
<script src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
<div id="posts-chart"style="border-radius: 8px; height: 190px; padding: 10px;"></div>
```
这两行代码在任意的 `md` 文件中也可以添加～不如就加在这里展示一下～

<script src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
<div id="posts-chart"style="border-radius: 8px; height: 190px; padding: 10px;"></div>

# 总结陈词
至此这回的博客装修就阶段性完工啦～还是挺有成就感的，真的是一种单车变摩托的感觉，虽然主要还是靠 fluid 的模板啦🤣 不过通过添加「随机游走」功能还有热力图还是学到了一些新东西（虽然只是让它能 work 了的程度）。希望装修完成的喜悦可以推动我多发几篇博客吧哈哈哈～