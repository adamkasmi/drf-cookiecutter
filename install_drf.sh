---

### Modified `install_django.sh` Script:
```bash
#!/bin/bash

# Check if arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <app_name>"
    exit 1
fi

PROJECT_NAME=$1
APP_NAME=$2
SCRIPT_DIR="$(pwd)"

# Step 1: Create a virtual environment in the parent directory
cd ..
python3 -m venv venv

# Step 2: Activate the virtual environment and install necessary packages
source venv/bin/activate
pip install django djangorestframework

# Step 3: Create a new Django project
django-admin startproject $PROJECT_NAME

# Change directory to the new project directory
cd $PROJECT_NAME

# Step 4: Create the new app within the project directory
django-admin startapp $APP_NAME

# Step 5: Modify settings.py
echo "INSTALLED_APPS += ['$APP_NAME', 'rest_framework']" >> $PROJECT_NAME/settings.py
echo "REST_FRAMEWORK = {'DEFAULT_PERMISSION_CLASSES': ['rest_framework.permissions.AllowAny']}" >> $PROJECT_NAME/settings.py

# Step 6: Copy the template app files into the new app directory
cp $SCRIPT_DIR/basic_api/* $APP_NAME/

# Step 7: Modify main project's urls.py to include the new app's urls
echo "from django.urls import include" >> $PROJECT_NAME/urls.py
echo "urlpatterns += [path('api/', include('$APP_NAME.urls'))]" >> $PROJECT_NAME/urls.py

# Step 8: Add a basic model to the new app's models.py
echo "class BasicModel(models.Model):" >> $APP_NAME/models.py
echo "    name = models.CharField(max_length=100)" >> $APP_NAME/models.py

# Step 9: Create and Apply Migrations
python manage.py makemigrations $APP_NAME
python manage.py migrate

# Step 10: Start the Django development server
python manage.py runserver &

# Open a web browser to the API endpoint
xdg-open 'http://127.0.0.1:8000/api/basic/'
