from django.urls import path
from . import views

urlpatterns = [
    path('basic/', views.BasicModelListCreate.as_view(), name='basicmodel_listcreate'),
]
