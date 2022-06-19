from rest_framework import serializers
from .models import Todolist

class TodolistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Todolist
        fields = ('id', 'title','detail')  #'__all__' เอาทุกอย่างที่จะ save
