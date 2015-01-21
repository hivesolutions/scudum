{% extends "partials/layout_simple.html.tpl" %}
{% block links %}
    {% if link == "home" %}
        <a href="{{ url_for('base.index') }}" class="active">home</a>
    {% else %}
        <a href="{{ url_for('base.index') }}">home</a>
    {% endif %}
{% endblock %}
