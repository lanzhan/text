# 一、maven类似于jar包管理工具，它可以解决以下问题：
##
* 1\.解决jar包冲突。
* 2\.jar依赖
* 3\.jar文件不用在每个项目保存，只需要放在仓库即可
* 4\.maven可以指定jar的依赖范围
# 二、maven仓库
* 1\.本地仓库
> * 本地仓库：Maven在本机存储构件的地方，即那个.m2/repository
* 2\.远程仓库
> * 2.1中央仓库:包含了绝大多数流行的开源Java构件，以及源码、作者信息、SCM、信息、许可证信息等。开源的Java项目依赖的构件都可以在这里下载到。
中央仓库的地址：http://repo1.maven.org/maven2/
> * 2.2私服：是一种特殊的远程仓库，它是架设在局域网内的仓库。
 （在没有使用私服的情况下，查找jar包先去本地，没有再去中央仓库下载。
   而在使用了私服的情况下，查找jar包先去本地，没有去私服，然后才是中央仓库）
>* 2.3其他公共库
# 三、maven坐标（用来唯一标识一个构建的统一规范）:主要由三部分组成，分别是groupId、artifactId、version简称GAV
##
* 1\.groupId是项目组织唯一的标识符，实际对应包的结构
* 2\.artifactID就是项目的唯一的标识符，实际对应项目的名称
* 3\.version版本号
* 4\.packaging定义了该项目的打包方式，一般为jar可有可无
、、、
 <groupId>com.example</groupId>
 <artifactId>demo</artifactId>
 <version>0.0.1-SNAPSHOT</version>
 <packaging>jar</packaging>
、、、
# 四、maven依赖管理
* 1\.依赖范围scope， 用来控制依赖和编译，测试，运行的classpath的关系。具体的依赖范围有如下6种：
> * compile： 默认编译依赖范围。对于编译，测试，运行三种classpath都有效
> * test：测试依赖范围。只对于测试classpath有效
> * provided：已提供依赖范围。对于编译，测试的classpath都有效，但对于运行无效。因为由容器已经提供，例如servlet-api
> * runtime：运行时提供。例如:jdbc驱动
> * system：系统范围,自定义构件，指定systemPath；跟provided 相似，但是在系统中要以外部JAR包的形式提供，maven不会在repository查找它。
> * import：只使用在<dependencyManagement>中，表示从其它的pom中导入dependency的配置。
