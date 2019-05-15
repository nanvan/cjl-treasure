# 一.main方法

![1557796338290](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557796338290.png)

1.public: 让别人来调用

2.static: 这样就省了去堆里new对象(把类装载到方法区),起到提速作用

3.void: 由java虚拟机内存调用,不需要什么返回值

4.String[] args: 在windows的cmd下java ClassName one two "three four" 会输出1和2和3,4 这可以在main方法里写if(linux),if(windows)然后执行不同的业务



# 二.内部类,匿名内部类

![1557797837943](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557797837943.png)

$后面的是内部类,![1557798386238](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557798386238.png)

HashMap里有很多内部类(当有个类只被一个类使用时可以这么写)

![1557798605036](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557798605036.png)

![1557798729966](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557798729966.png)

![1557798741465](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557798741465.png)



## 匿名内部类

java8: lamda表达式

![1557799141965](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557799141965.png)



###### 													该类不能被继承

![1557799293143](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557799293143.png)



# 反射



![1557802111439](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557802111439.png)

![1557802062954](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557802062954.png)

###### Modifer:修饰符,如public protected

###### java动态代理实现是基于反射(Reflection)



# 动态代理

![1557802791888](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557802791888.png)



Cglib 字节码技术,反射最多修改对象的属性,cglib直接修改class代码

![1557805315335](C:\Users\13750\AppData\Roaming\Typora\typora-user-images\1557805315335.png)



重定向：以前的request中存放的变量全部失效，并进入一个新的request作用域。 

转发：以前的request中存放的变量不会失效，就像把两个页面拼到了一起。  

request.getRequestDispatcher("apage.jsp").forward(request, response);//转发到apage.jsp

response.sendRedirect("apage.jsp");//重定向到apage.jsp  