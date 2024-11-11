# app/__init__.py

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from .config import Config

# Crear instancias de SQLAlchemy y LoginManager
db = SQLAlchemy()
login_manager = LoginManager()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Inicializar la base de datos y LoginManager con la configuración de la aplicación
    db.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = 'routes.login'  # Redirigir a la vista de login si el usuario no está autenticado

    # Registrar el Blueprint de rutas
    from .routes import routes
    app.register_blueprint(routes)

    # Crear todas las tablas en la base de datos si no existen
    with app.app_context():
        db.create_all()

    return app

# Configuración del cargador de usuario para Flask-Login
@login_manager.user_loader
def load_user(user_id):
    from .models import Jugador
    return Jugador.query.get(int(user_id))
