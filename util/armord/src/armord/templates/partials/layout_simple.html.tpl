{% extends "partials/layout.static.html.tpl" %}
{% block htitle %}{{ own.description }} / {% block title %}{% endblock %}{% endblock %}
{% block head %}
    {{ super() }}
    <link rel="stylesheet" type="text/css" href="{{ url_for('static', filename = 'css/layout.css') }}" />
    <script type="text/javascript" src="//libs.bemisc.com/pushi/pushi.js"></script>
    <script type="text/javascript" src="{{ url_for('static', filename = 'js/main.js') }}"></script>
{% endblock %}
{% block footer %}
    &copy; Copyright 2008-2015 by <a href="http://hive.pt">Hive Solutions</a>.<br />
    {% if session['username'] %}<span>{{ session['username'] }}</span> // <a href="{{ url_for('admin.logout') }}">logout</a><br />{% endif %}
    <div class="button footer-logo" data-link="{{ url_for('base.index') }}"></div>
{% endblock %}
