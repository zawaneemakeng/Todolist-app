from django.db import models 
#ใช้สำหรับการจัดเก็บข้อมูลเข้าไปในระบบ database ของdjango

class Todolist(models.Model):
    title = models.CharField(max_length=100) #ต้องการเก็บกี่ตัว
    detail = models.TextField(blank=True,null=True)#ช่องนี้ไม่บังคับใส่  ว่างได้ ถ้าใส่null อย่างเดียวฝั่งเเอดมินไม่สามารถเเอดได้

    def __str__(self):
        return self.title