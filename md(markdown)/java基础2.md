# java基础

![1557727254342](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557727254342.png)

![1557727350870](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557727350870.png)



## jvm运行时内存结构 & jmm java内存模型

java代码都存在了jvm

###### 线程共享区(不安全):

​						**堆**:存对象(如Student.java)

​						**方法区**:存常量,静态变量

###### 线程私有(安全):

​				**程序计数器**(由系统维护):记录代码执行到了哪一行

​				**栈**:线程在这,一个栈帧对应一个方法

​				**本地方法栈**:比如调用C语言写的方法

![1557730019999](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557730019999.png)

![1557729964663](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557729964663.png)

## JMM

![1557731292785](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557731292785.png)



###### new Object();拢共分几步?

​		![1557737131974](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557737131974.png)