from django.shortcuts import render
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TodolistSerializer
from .models import Todolist
#GET data
@api_view(['GET'])
def all_todolist(request):
        alltodolist =Todolist.objects.all() # ดึงข้อมูล model todolist
        serializer = TodolistSerializer(alltodolist,many=True) # ขอมูลที่ส่งข้อมูลมากว่า1
        return Response(serializer.data,status=status.HTTP_200_OK)

# POST Data or Save data 
@api_view(['POST'])
def post_todolist(request):
        if request.method =='POST':
                serializer = TodolistSerializer(data=request.data)
                if serializer.is_valid():
                        serializer.save()
                        return Response(serializer.data,status = status.HTTP_201_CREATED)
                return Response(serializer.data,status = status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def put_todolist(request,TID):
        todo = Todolist.objects.get(id = TID) #รายการตัวนึง
        # จากตาราง  todolist จะดึงข้อมูล จากid  /updadate/tid ส่งid
        if request.method =='PUT':
                data = {}
                serializer = TodolistSerializer(todo,data=request.data) #get data จาก todo list เข้าไป
                if serializer.is_valid():
                        serializer.save()
                        data['status'] = 'updated'
                        return Response(data = data ,status = status.HTTP_201_CREATED)
                return Response(serializer.errors,status = status.HTTP_404_NOT_FOUND)        


@api_view(['DELETE'])
def delete_todolist(request,TID):
        todo = Todolist.objects.get(id = TID) #รายการตัวนึง

        if request.method =='DELETE': #ถ้าลบdata ได้ จะ
                delete = todo.delete() #ลบ data
                data = {}
                if delete:
                        data['status'] = 'deleted'
                        statuscode = status.HTTP_200_OK
                else:
                        data['status'] = 'failed'
                        statuscode = status.HTTP_404_NOT_FOUND

                return Response(data = data ,status = statuscode)


data = [{
        "title": "Atomic habits",
        "subtitle": "นี่คือหนังสือเกี่ยวกับการเปลี่ยนแปลงนิสัย โดยใช้หลักการทางวิทยาศาสตร์มาอ้างอิง",
        "image_url": "https://raw.githubusercontent.com/zawaneemakeng/BasicAPI/main/images/atomic.jpg",
        "detail": "จากหนังสือขายดีระดับโลกที่มียอดขายหลายล้านเล่ม แปลไปแล้วกว่า 40 ภาษา การันตีความดีงามโดย New York Times Bestseller นี่คือหนังสือเกี่ยวกับการเปลี่ยนแปลงนิสัย โดยใช้หลักการทางวิทยาศาสตร์มาอ้างอิงว่าการเปลี่ยนแปลงเล็ก ๆ ที่เล็กมาก ๆ จะนำไปสู่การเปลี่ยนแปลงที่ใหญ่ขึ้นได้อย่างไร ซึ่งหลักการนี้สามารถประยุกต์ใช้ได้กับทุกเรื่อง เช่น การทำงาน การเงิน ความสัมพันธ์ระหว่างบุคคล สุขภาพ ความคิดสร้างสรรค์ ไม่ว่าเป้าหมายของเราคืออะไรก็ตาม หนังสือเล่มนี้จะช่วยเปลี่ยนแปลงนิสัยและคงนิสัยดี ๆ ไว้ได้นานเท่านาน \n\n     หากคุณพยายามเปลี่ยนแปลงตัวเองแต่ไม่สำเร็จสักที หนังสือเล่มนี้ช่วยคุณได้! ด้วยการพัฒนาตัวเองให้ดีขึ้นเพียงวันละ 1% ไม่ว่าเป้าหมายในชีวิตของคุณคืออะไร คุณทำสำเร็จได้อย่างแน่นอน!"
        },
        {
        "title": "Ai Superpowers",
        "subtitle": "จะเกิดอะไรขึ้น ถ้าตอนนี้จีนอยากท้าทายอเมริกา เพื่อขึ้นมาเป็นผู้นำเทคโนโลยีที่จะเปลี่ยนโลกนี้โดยสิ้นเชิง?",
        "image_url": "https://raw.githubusercontent.com/zawaneemakeng/BasicAPI/main/images/ai.jpg",
        "detail": "จากที่เป็นเรื่องสมมติในภาพยนตร์ เป็นของเล่นในห้องทดลอง ตอนนี้ AI พัฒนามาถึงจุดที่ใช้ได้จริงเรียบร้อยแล้ว มันจะเปลี่ยนชีวิตเราอย่างรุนแรงเทียบเท่าไฟฟ้า และยิ่งกว่าอินเทอร์เน็ต\n\nจากที่ถูกตราหน้าเป็นดินแดนขี้ก๊อป สกปรก และยากจน จีนใช้เวลา 30 ปี ไล่ทันอารยธรรมตะวันตกที่สร้างมา 500 ปี... แล้วจะเกิดอะไรขึ้น ถ้าตอนนี้จีนอยากท้าทายอเมริกา เพื่อขึ้นมาเป็นผู้นำเทคโนโลยีที่จะเปลี่ยนโลกนี้โดยสิ้นเชิง? หลี่ไคฟู อดีตประธานกูเกิลไชน่าและนักลงทุนชื่อดัง เชื่อว่า 10 ปีข้างหน้าจะเกิดการเปลี่ยแปลงครั้งใหญ่ในรอบร้อยปี! คุณจะไม่ถูกทิ้งไว้ข้างหลังและคว้าโอกาสที่ดีให้ตัวเองและลูกหลายได้อย่างไร? ค้นหาคำตอบพร้อมกันได้ในเล่ม"
        },
        {
        "title": "Thinking Fast and Slow",
        "subtitle": "สำรวจความบกพร่องในการตัดสินใจของมนุษย์ ผ่านมุมมองของนักคิดและนักจิตวิทยาที่ยิ่งใหญ่ที่สุดแห่งยุค",
        "image_url": "https://raw.githubusercontent.com/zawaneemakeng/BasicAPI/main/images/thinkingjpg.jpg",
        "detail": "หนังสือเล่มนี้จะพาคุณไปสำรวจ การคิดสองแบบ  นั่นคือ การคิดเร็วและการคิดช้า ซึ่งทำหน้าที่กำหนดการตัดสินใจและพฤติกรรมทั้งหมดของมนุษย์เรา ผ่านมุมมองอันเฉียบคมของ แดเนียล คาห์ เนแมน  นักจิตวิทยาเจ้าของรางวัลโนเบล ที่ได้รับฉายาว่าเป็น  บิดาแห่ งเศรษฐศาสตร์ เชิงพฤติกรรม  และนักคิดที่ลุ่มลึกที่สุดแห่งยุค โดยเนื้อหาในเล่มสรุปมาจากการรวบรวมผลการศึกษาวิจัยตลอด 40 ปี ของผู้เขียน ที่ตั้งใจถ่ายทอดองค์ความรู้เรื่องนี้สู่ผู้อ่าน ด้วยภาษาที่เข้าใจง่าย มีตัวอย่างทำให้เห็นภาพชัดเจน"
        },
        {
        "title": "เศรษฐีชี้ทางรวย",
        "subtitle": "คัมภีร์การเงินคลาสสิกเหนือกาลเวลาเกือบศตวรรษ เผยความลับแห่งความมั่งคั่ง จากการหาเงิน เก็บออม และทำให้เงินงอกเงย",
        "image_url": "https://raw.githubusercontent.com/zawaneemakeng/BasicAPI/main/images/babylon.jpg",
        "detail": "การจัดการค่าใช้จ่ายต่าง ๆ ดูเหมือนจะเป็นเรื่องยากสำหรับใครหลาย ๆ คน เพราะเรามักโดนหลอกระหว่างความต้องการในสิ่งที่จำเป็นจริง ๆ และความปรารถนาในสิ่งสวยงามล่อใจ สุดท้าย ความปรารถนาก็ดึงเงินมากมายออกจากกระเป๋าเราโดยไม่รู้ตัว ทุก ๆ เดือนจึงไม่มีเงินเก็บ หนำซ้ำยังมีหนี้สินอีก\n\nหนังสือ เศรษฐีชี้ทางรวย เป็นเหมือนแรงบันดาลใจ ช่วยกระตุ้นให้ผู้อ่านกลับมาพิจารณาการใช้เงินของตัวเอง ปรับเปลี่ยนนิสัยเดิม ๆ   ที่เคยชิน จนหลุดพ้นจากวงจรหนี้สิน แม้ว่าหนังสือจะเขียนขึ้นมาในรูปแบบนิยาย แต่อ่านแล้วมีข้อคิดมากมาย ที่ทำให้ผู้อ่านฮึกเหิม พร้อมลุกขึ้นมาปฏิวัติตัวเอง เปลี่ยนแปลงมาใช้เงินในทางที่ถูก จนนำไปสู่ความมั่นคงด้านการเงินในที่สุด"
        }
        ]


def Home(request):
    # safe=Falseคือบอกว่าไม่ใช้json หรือdict
    return JsonResponse(data=data, safe=False,json_dumps_params={'ensure_ascii':False})
