# app/config.py

import os

class Config:
    SQLALCHEMY_DATABASE_URI = 'postgresql://connector:connector@localhost/minecraft_bd'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = os.urandom(24)
