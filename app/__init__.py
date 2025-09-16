
from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics
from app.routes.user_routes import user_blueprint
from app.routes.product_routes import product_blueprint

def create_app():
    app = Flask(__name__)
    
    # Initialize metrics
    PrometheusMetrics(app)

    # Register blueprints
    app.register_blueprint(user_blueprint)
    app.register_blueprint(product_blueprint)

    return app
