#!/bin/bash

# Check if arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <app_name>"
    exit 1
fi

PROJECT_NAME=$1
APP_NAME=$2
SCRIPT_DIR="$(dirname "$0")"

# Step 1: Create a virtual environment in the parent directory
cd ..
python3 -m venv venv

# Step 2: Activate the virtual environment and install necessary packages
source venv/bin/activate
pip install django djangorestframework

# Step 3: Create a new Django project and app
django-admin startproject $PROJECT_NAME
django-admin startapp $APP_NAME $PROJECT_NAME/$APP_NAME

# Step 4: Modify settings.py
echo "INSTALLED_APPS += ['$APP_NAME', 'rest_framework']" >> $PROJECT_NAME/$PROJECT_NAME/settings.py
echo "REST_FRAMEWORK = {'DEFAULT_PERMISSION_CLASSES': ['rest_framework.permissions.AllowAny']}" >> $PROJECT_NAME/$PROJECT_NAME/settings.py

# Step 5: Copy the template app files into the new app directory
cp $SCRIPT_DIR/basic_api/* $PROJECT_NAME/$APP_NAME/

# Step 6: Migrate and start the server
cd $PROJECT_NAME
python manage.py migrate
python manage.py runserver
