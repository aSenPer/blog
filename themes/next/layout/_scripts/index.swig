{% include 'vendors.swig' %}

{{- next_js('utils.js') }}
{%- if theme.motion.enable %}
  {{- next_js('motion.js') }}
{%- endif %}

{%- set scheme_script = 'schemes/' + theme.scheme | lower + '.swig' %}
{% include scheme_script %}

{{- next_js('next-boot.js') }}
{%- if theme.bookmark.enable %}
  {{- next_js('bookmark.js') }}
{%- endif %}
{%- if theme.pjax %}
  {% include 'pjax.swig' %}
{%- endif %}
{% include 'three.swig' %}
{{- js('https://cdn.jsdelivr.net/jquery/2.1.3/jquery.min.js') }}
{{- next_js('lightGallery.min.js') }}
<script>

$(document).ready(function() {
  $(".post-gallery").lightGallery({
    thumbnail   : true,  // Whether to display a button to show thumbnails.
      caption     : false, // Enables image captions. Content is taken from "data-title" attribute.
      captionLink : false, // Makes image caption a link. URL is taken from "data-link" attribute.
      desc        : false, // Enables image descriptions. Description is taken from "data-desc" attr.
      counter     : true, // Shows total number of images and index number of current image.
      controls    : true,  // Whether to display prev/next buttons.
  
      // Transitions
      mode   : 'fade',  // Type of transition between images. Either 'slide' or 'fade'.
      useCSS : true,     // Whether to always use jQuery animation for transitions or as a fallback.
      easing : 'linear', // Value for CSS "transition-timing-function" prop. and jQuery .animate().
      speed  : 500,     // Transition duration (in ms).
  
      // Navigation
      hideControlOnEnd : true, // If true, prev/next button will be hidden on first/last image.
      loop             : false, // Allows to go to the other end of the gallery at first/last img.
      auto             : false, // Enables slideshow mode.
      pause            : 4000,  // Delay (in ms) between transitions in slideshow mode.
      escKey           : true,  // Whether lightGallery should be closed when user presses "Esc".
  
      // Mobile devices
      mobileSrc         : false, // If "data-responsive-src" attr. should be used for mobiles.
      mobileSrcMaxWidth : 640,   // Max screen resolution for alternative images to be loaded for.
      swipeThreshold    : 500,    // How far user must swipe for the next/prev image (in px).
  
      // Video
      vimeoColor    : 'CCCCCC', // Vimeo video player theme color (hex color code).
      videoAutoplay : true,     // Set to false to disable video autoplay option.
      videoMaxWidth : 855,      // Limits video maximal width (in px).
  
      // i18n
      lang : { allPhotos: 'All photos' }, // Text of labels.
  
      // Callbacks
      onOpen        : function() {}, // Executes immediately after the gallery is loaded.
      onSlideBefore : function() {}, // Executes immediately before each transition.
      onSlideAfter  : function() {}, // Executes immediately after each transition.
      onSlideNext   : function() {}, // Executes immediately before each "Next" transition.
      onSlidePrev   : function() {}, // Executes immediately before each "Prev" transition.
      onBeforeClose : function() {}, // Executes immediately before the start of the close process.
      onCloseAfter  : function() {}, // Executes immediately once lightGallery is closed.
  
      // Dynamical load
      dynamic   : false, // Set to true to build a gallery based on the data from "dynamicEl" opt.
      dynamicEl : [],    // Array of objects (src, thumb, caption, desc, mobileSrc) for gallery els.
  
      // Misc
      rel          : false, // Combines containers with the same "data-rel" attr. into 1 gallery.
      exThumbImage : false, // Name of a "data-" attribute containing the paths to thumbnails.
  });
});
</script>


