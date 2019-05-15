![1557288092580](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557288092580.png)

mq没有选举(即主挂了,从不会替代主)



![1557295337781](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557295337781.png)



![1557295572927](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557295572927.png)



![1557295787139](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557295787139.png)



两种刷盘类型(rocketmq是异步刷:效率更高,缺点是可能造成数据丢失):ASYNC异步,SYNC同步,

这里的异步指:send message到broker直接返回; 同步是send message到broker后先刷到硬盘里再返回

![1557296829304](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557296829304.png)



![1557297209404](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557297209404.png)

​																			m:master           s:slave

![1557297359259](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557297359259.png)

ls -lrt 查看该文件的链接指向

![1557307884544](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557307884544.png)

高可用性(HA):high-availability

↓解决↓

单点故障:no single point of failure



![1557294511794](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557294511794.png)

