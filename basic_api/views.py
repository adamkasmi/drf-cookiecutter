from rest_framework import generics
from .models import BasicModel
from .serializers import BasicModelSerializer

class BasicModelListCreate(generics.ListCreateAPIView):
    queryset = BasicModel.objects.all()
    serializer_class = BasicModelSerializer
