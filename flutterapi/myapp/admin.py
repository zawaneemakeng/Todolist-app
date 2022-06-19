from django.contrib import admin
from .models  import Todolist#เเอดจากโมเดล ดึงตัวmodels

admin.site.register(Todolist) #ทำให้โมเดลนี้อยู๋ฝั่งเเอดมิน
