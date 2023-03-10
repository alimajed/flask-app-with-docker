from flask import Flask

from config import ConfigFactory

def init_app():
    app = Flask(__name__)
    # load config form config class
    app.config.from_object(ConfigFactory.factory().__class__)

    with app.app_context():
        # import blueprints
        from app.home.views import home_bp

        # register blueprints
        app.register_blueprint(home_bp, url_prefix="/home")

        return app