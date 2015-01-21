{% extends "partials/layout_simple.html.tpl" %}
{% block links %}
    {% if link == "home" %}
        <a href="{{ url_for('base.index') }}" class="active">home</a>
    {% else %}
        <a href="{{ url_for('base.index') }}">home</a>
    {% endif %}
    //
    {% if link == "about" %}
        <a href="{{ url_for('base.about') }}" class="active">about</a>
    {% else %}
        <a href="{{ url_for('base.about') }}">about</a>
    {% endif %}
{% endblock %}
