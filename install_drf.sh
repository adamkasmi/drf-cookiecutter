#!/bin/bash

# Check if arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <app_name>"
    exit 1
fi

APP_NAME=$1

# Step 1: Create a virtual environment
python3 -m venv venv

# Step 2: Activate the virtual environment and install necessary packages
source venv/bin/activate
pip install django djangorestframework

# Step 3: Create a new Django project and app
django-admin startproject myproject .
django-admin startapp $APP_NAME

# Step 4: Modify settings.py
echo "INSTALLED_APPS += ['$APP_NAME', 'rest_framework']" >> myproject/settings.py
echo "REST_FRAMEWORK = {'DEFAULT_PERMISSION_CLASSES': ['rest_framework.permissions.AllowAny']}" >> myproject/settings.py

# Step 5: Migrate and start the server
python manage.py migrate
python manage.py runserver

# Note: This script will end here, but the server will continue running until stopped by the user.
