---

layout:    post
title:    "开发日志1"
subtitle:    "目录"
date:    2026-08-05 10:00:00
author:    "lyn"
header-img: "img/aeneas-departing-from-troy.jpg"
catalog: true
tags: 
    - Flask
    - python
    - html
    - MySQL
mathjax: true
mermaid: true

---
# Log 1

## 众所周知，我现在在开发一个AI辅助的实验报告写作网站……

目前为止（在deepseek的帮助下）搭好了Flask框架，并开始了前后端开发的同步学习。

后端技术中，Flask和MySQL可谓是绝代双骄，Flask的轻量化与MySQL强大的数据管理技术可以很好地结合，并通过VScode这个IDE用python语言编辑和处理。

MySQL作为数据库，其标准化的查询、操作、建立数据库的能力是毋庸置疑的，但是其短板在于处理在线请求和发送反馈上。MySQL直接将数据写入服务器磁盘，这就导致每一次调用请求都涉及一次低效的*IO*。据统计，一个只搭载了MySQL的服务器至多只能在一秒钟内处理五万个请求，而一个比较热门的网站一秒钟内收到的访问请求往往在十万次以上。所以光有一个强大的数据储存工具还不足以运转一个网站，我们需要像电脑内存之于CPU一样，建立一个数据的缓存和初步处理的前置“池”，使得短时间内大量的查询被打入这个池，而不至于直接挑战数据库的处理能力。为此我选择了**redis**（**Re**mote **Di**ctionary **S**ervice）这个服务器充当中间的缓冲池。

这一块主要聚焦于后端开发经验，我将从 **1.Flask的建立与基本语法**；**2.Redis的下载与安装**；**3.IDE环境中MySQL的基本操作**三个方面出发，总结一下迄今为止我学到的技术和注意事项。并且在最后，我会通过一个实例——**生成请求ID并且调用binary()方法，返回该ID对应请求的二进制数**——来展示一下Flask，Redis和MySQL的联动机制。

### redis队列：

#### redis的下载与安装

##### 方法一：从github直接下载大佬打包好的windows版本的redis服务器

下载地址：

##### 方法二：在docker里拉下redis镜像

##### 方法三：在Linux中安装redis

#### redis的功能

redis队列的工作可以分成3步：用户给出要求，redis队列的连接与维护，以及最后给用户反馈结果。

**Json格式**是一种所有浏览器和编译器通用且可读性较强的数据传输格式，其标准格式为：

```json
{
    "key1":'xxxxxx',
    "key2":'xxxxxx',
    "key3":'xxxxxx'
}
```

需要注意的是，为保证后端程序读取的便捷性，json格式的文件**键名必须用双引号包围，且整个代码块中不能有注释**。

在python中，将字典类转换成json格式文件，以及将json格式文件转化成python的字典类，使用的分别是`json`包里的`jsonify()`和`json.dumps()`函数。


```python
@app.route("/submit_task", methods=["POST"])
def submit_task():
# 1.生成任务id
    index=str(uuid.uuid4())

# 2.连接redis队列
    redis_connect= {
        "host":"127.0.0.1",
        "port":6379,
        "password":"123456",
        "encoding":"utf-8"
    }
    conn=redis.Redis(**redis_connect)

# 3.将任务id存入redis队列
    conn.lpush("task_queue", json.dumps({"task_id": index}))

# 4.给用户返回
    return jsonify({ "status" : "success" , "task_id" : index , "msg" : "任务已提交，请稍后查询结果！" })

```

<!-- markdownlint-disable MD033 -->
<model-viewer 
  src="/assets/models/cone_surface.glb" 
  alt="圆锥面 z = sqrt(x^2 + y^2)" 
  auto-rotate 
  camera-controls
  style="width: 100%; height: 500px;">
</model-viewer>
<!-- markdownlint-enable MD033 -->

