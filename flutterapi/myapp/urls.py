from django.urls import path
from .views import *

urlpatterns = [
    path('', Home),
    path('api/all-todolist/', all_todolist)  ,# localhost:8000/api/all-todolist
    # localhost:8000/api/create-todolist
    path('api/post-todolist', post_todolist),
    path('api/update-todolist/<int:TID>',put_todolist),
    path('api/delete-todolist/<int:TID>',delete_todolist)


]
