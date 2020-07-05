/* global NexT, CONFIG, Velocity */

NexT.boot = {};

NexT.boot.registerEvents = function () {

  NexT.utils.registerScrollPercent();
  NexT.utils.registerCanIUseTag();

  // Mobile top menu bar.
  document.querySelector('.site-nav-toggle .toggle').addEventListener('click', () => {
    event.currentTarget.classList.toggle('toggle-close');
    var siteNav = document.querySelector('.site-nav');
    var animateAction = siteNav.classList.contains('site-nav-on') ? 'slideUp' : 'slideDown';

    if (typeof Velocity === 'function') {
      Velocity(siteNav, animateAction, {
        duration: 200,
        complete: function () {
          siteNav.classList.toggle('site-nav-on');
        }
      });
    } else {
      siteNav.classList.toggle('site-nav-on');
    }
  });

  var TAB_ANIMATE_DURATION = 200;
  document.querySelectorAll('.sidebar-nav li').forEach((element, index) => {
    element.addEventListener('click', event => {
      var item = event.currentTarget;
      var activeTabClassName = 'sidebar-nav-active';
      var activePanelClassName = 'sidebar-panel-active';
      if (item.classList.contains(activeTabClassName)) return;

      var targets = document.querySelectorAll('.sidebar-panel');
      var target = targets[index];
      var currentTarget = targets[1 - index];
      window.anime({
        targets: currentTarget,
        duration: TAB_ANIMATE_DURATION,
        easing: 'linear',
        opacity: 0,
        complete: () => {
          // Prevent adding TOC to Overview if Overview was selected when close & open sidebar.
          currentTarget.classList.remove(activePanelClassName);
          target.style.opacity = 0;
          target.classList.add(activePanelClassName);
          // if($('.site-overview-wrap').hasClass('sidebar-panel-active')){
          //   $(".widget-wrap").show()
          // }else{
          //   $(".widget-wrap").hide()
          // }
          $('.site-overview-wrap').hasClass('sidebar-panel-active') ? $(".widget-wrap").show() : $(".widget-wrap").hide()
          window.anime({
            targets: target,
            duration: TAB_ANIMATE_DURATION,
            easing: 'linear',
            opacity: 1
          });
        }
      });

      [...item.parentNode.children].forEach(element => {
        element.classList.remove(activeTabClassName);
      });
      item.classList.add(activeTabClassName);

    });
  });

  window.addEventListener('resize', NexT.utils.initSidebarDimension);

  window.addEventListener('hashchange', () => {
    var tHash = location.hash;
    if (tHash !== '' && !tHash.match(/%\S{2}/)) {
      var target = document.querySelector(`.tabs ul.nav-tabs li a[href="${tHash}"]`);
      target && target.click();
    }
  });

};

NexT.boot.refresh = function () {

  /**
   * Register JS handlers by condition option.
   * Need to add config option in Front-End at 'layout/_partials/head.swig' file.
   */
  CONFIG.fancybox && NexT.utils.wrapImageWithFancyBox();
  CONFIG.mediumzoom && window.mediumZoom('.post-body :not(a) > img, .post-body > img');
  if (!$(".post-body").hasClass('post-gallery')) {
    CONFIG.lazyload && window.lozad('.post-body img').observe();

  }

  CONFIG.pangu && window.pangu.spacingPage();

  CONFIG.exturl && NexT.utils.registerExtURL();
  CONFIG.copycode.enable && NexT.utils.registerCopyCode();
  NexT.utils.registerTabsTag();
  NexT.utils.registerActiveMenuItem();
  NexT.utils.registerLangSelect();
  NexT.utils.registerSidebarTOC();
  NexT.utils.wrapTableWithBox();
  NexT.utils.registerVideoIframe();
};

NexT.boot.motion = function () {
  // Define Motion Sequence & Bootstrap Motion.
  if (CONFIG.motion.enable) {
    NexT.motion.integrator
      .add(NexT.motion.middleWares.logo)
      .add(NexT.motion.middleWares.menu)
      .add(NexT.motion.middleWares.postList)
      .add(NexT.motion.middleWares.sidebar)
      .bootstrap();
  }
  NexT.utils.updateSidebarPosition();
};

window.addEventListener('DOMContentLoaded', () => {
  NexT.boot.registerEvents();
  NexT.boot.refresh();
  NexT.boot.motion();
});
// 图片
var imgs = $(".post-gallery img")
imgs.parent().attr("id", 'lightGallery')
imgs.each(function (v, i) {
  $(i).data("src", $(i).data("src") + "?imageslim")
  $(i).attr("src", $(i).data("src"))
  $(i).attr("loaded", true)
  var src = $(i).data("src") || $(i).attr("src");
  $(this).replaceWith('<div data-src=' + src + '> <a href="javascript:;">' + $(i)[0].outerHTML + '</a> </div>')
})
$("#lightGallery br").remove()
$(".post-gallery p").justifiedGallery({
  rowHeight: '100%'
});
lightGallery(document.querySelector("#lightGallery"), {
  thumbnail: true,
  getCaptionFromTitleOrAlt: true,
  pause: 3500,
  subHtmlSelectorRelative: false
});
// 视频
if(DPlayer){
  var videos = document.querySelectorAll('video')
  videos.forEach((e, i) => {
    $(e).replaceWith('<div id="dplayer' + i + '" style="width:100%;height:40%;"></div>')
    new DPlayer({
      container: document.getElementById('dplayer'+i),
      video: {
        url: $(e).attr('src'),
      },
    })
  })
}

