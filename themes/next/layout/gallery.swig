{% macro render(posts,type) %}
{%- set current_year = '1970' %}
{%- for post in posts.toArray().reverse() %}
  {%- set year = date(post.date, 'YYYY') %}
  {%- if post.type %}
    
    <div class="photos-gutter"></div>
    <article itemscope itemtype="http://schema.org/Article" class="photos">
        <div class="photos-meta">
          <div data-src="{{ url_for(post.photos) }}">
              <img src="{{ url_for(post.photos) }}" itemprop="contentUrl">
          </div>
          <div class="collection-year photos-width100">
            <span class="collection-header">{{ year }}</span>
          </div>
          <div class="photos-info">
            <div class="post-time">
              <span itemprop="dateCreated"
                    datetime="{{ moment(post.date).format() }}"
                    content="{{ date(post.date, config.date_format) }}">
                {{ date(post.date, 'MM-DD') }}
              </span>
            </div>
            <div class="post-title">
              {%- if post.link %}{# Link posts #}
                {%- set postTitleIcon = '<i class="fa fa-external-link-alt"></i>' %}
                {%- set postText = post.title or post.link %}
                {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url'}) }}
              {% else %}
                <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
                  <span itemprop="name">{{ post.title or __('post.untitled') }}</span>
                </a>
              {%- endif %}
            </div>
          </div>
        </div>
    </article>
  {%- endif%}
 
{%- endfor %}
{% endmacro %}
