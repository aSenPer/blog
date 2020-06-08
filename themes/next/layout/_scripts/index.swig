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
    loop:false,
    auto:false,
    pause:4000
  });
});
</script>


