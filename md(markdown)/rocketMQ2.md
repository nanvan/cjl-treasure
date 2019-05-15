pull拉:发送请求:

​			长轮询(consumer不断向broker询问该topic里是否有新的message)

​			实时性高,但消耗资源

push推:就是pull

topic和producer多对多

![1557365836835](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557365836835.png)



网关=路由器()=入口(互联网由多个路由组成)

queue队列:先进先出

MQ:异步, 解耦, 限流, 消峰

rocketMQ模块:

​		1.store:用来做刷盘

​												rocketmq的异步生产者(AsyncProducer.java)

![1557383531764](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557383531764.png)



![1557385160788](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557385160788.png)

![1557387417517](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557387417517.png)

![1557388751184](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557388751184.png)

![1557389233932](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557389233932.png)

有网络就有延迟,有延迟就有异步,有异步就有回调

​															顺序消费状态

![1557392902359](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557392902359.png)



int: 4字节, 4*8=32位, 1位用来表示正负符号, 所以是2^31