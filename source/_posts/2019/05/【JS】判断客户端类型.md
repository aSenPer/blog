---
title: 
date: 2019-05-22 10:29:25
tags: JS
categories: JS
---
# JS 判断客户端是iOS还是Android

> 判断的逻辑是：客户端不是Android，就是iOS，就是PC，其实还有黑莓BlackBerry、塞班SymbianOS、Windows Phone等，如果需要可自行添加，我在第三条有写。

## 通过浏览器的 navigator.userAgent 判断是Android还是iOS：

### 一. 判断是Android还是iOS
```js
    let u = navigator.userAgent;
    let isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;   //判断是否是 android终端
    let isIOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);     //判断是否是 iOS终端
    console.log('是否是Android：', isAndroid); //true,false
    console.log('是否是iOS：', isIOS)
```

*   封装成方法：

    ``  /*判断客户端*/
      judgeClient() {
        let u = navigator.userAgent;
        let isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;   //判断是否是 android终端
        let isIOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);     //判断是否是 iOS终端
        console.log('是否是Android：' + isAndroid); //true,false
        console.log('是否是iOS：' + isIOS);
        if(isAndroid){
          return 'Android';
        }else if(isIOS){
          return 'IOS';
        }else{
          return 'PC';
        }
      },```
    


### 二.判断是Android还是iOS
```js
    if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
      console.log('isIOS');
    } else if (/(Android)/i.test(navigator.userAgent)) {
      console.log('isAndroid');
    } else {
      console.log('isPC');
    }
    

*   封装成方法：
      /*判断客户端*/
      judgeClient() {
        let client = '';
        if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {  //判断iPhone|iPad|iPod|iOS
          client = 'iOS';
        } else if (/(Android)/i.test(navigator.userAgent)) {  //判断Android
          client = 'Android';
        } else {
          client = 'PC';
        }
        return client;
      },
    
```

### 三.判断PC还是移动端
```js
      isPC() {
        /*true则pc，false则mobile*/
        let u = navigator.userAgent;
        let Agents = ["Android", "iPhone", "webOS", "BlackBerry", "SymbianOS", "Windows Phone", "iPad", "iPod"];
        let flag = true;
        for (let i = 0; i < Agents.length; i++) {
          if (u.indexOf(Agents[i]) > 0) {
            flag = false;
            break;
          }
        }
        return flag;
      },
```


### 四.判断多种访问终端
```js
      //判断访问终端
      let browser = {
        versions: function () {
          let u = navigator.userAgent, app = navigator.appVersion;
          return {
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
            iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
            weixin: u.indexOf('MicroMessenger') > -1, //是否微信
            qq: u.match(/\sQQ/i) == " qq" //是否QQ
          };
        }(),
        language: (navigator.browserLanguage || navigator.language).toLowerCase()
      };

  使用

    if (browser.versions.mobile) {
        console.log("is mobile");
    }
    if (browser.versions.ios) {
        console.log("is ios");
    }
```



### 五.判断浏览器当前使用的语言

```js
 
  judgeLanguage() {
    // 判断浏览器当前使用的语言
    let currentLanguage = (navigator.browserLanguage || navigator.language).toLowerCase();    // 非IE
    if (!currentLanguage) {    // IE浏览器
      currentLanguage = navigator.browserLanguage;
    }
    console.log(currentLanguage);
    return currentLanguage;
  }
```