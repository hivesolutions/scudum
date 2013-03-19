{% extends "partials/layout_simple.html.tpl" %}
{% block title %}Login{% endblock %}
{% block name %}Login{% endblock %}
{% block content %}
    <div class="quote">
        Please provide your credentials to be able to access the restricted
        resources.<br />
        These values will <strong>not be visible to any element</strong>.
    </div>
    <div class="quote error">
        {{ error }}
    </div>
    <form action="" method="post" class="form">
        <div class="input">
            <input class="small" name="username" value="{{ username }}" placeholder="username" />
        </div>
        <div class="input">
            <input class="small" name="password" placeholder="password" type="password" />
        </div>
        <span class="button" data-link="#">Clear</span>
        //
        <span class="button" data-submit="true">Login</span>
    </form>
{% endblock %}
