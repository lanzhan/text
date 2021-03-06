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
# 三、maven坐标（用来唯一标识一个构建的统一规范）:主要由groupId、artifactId、version组成简称GAV
##
* 1\.groupId是项目组织唯一的标识符，实际对应包的结构
* 2\.artifactID就是项目的唯一的标识符，实际对应项目的名称
* 3\.version版本号
* 4\.packaging定义了该项目的打包方式，一般为jar可有可无，一些有效的打包值是jar，war，ear和pom，不同的包对应不同的生命周期阶段
```
<groupId>com.example</groupId>
 <artifactId>demo</artifactId>
 <version>0.0.1-SNAPSHOT</version>
 <packaging>jar</packaging>
```
# 四、maven依赖管理
* 1\.依赖范围scope， 用来控制依赖和编译，测试，运行的classpath的关系。具体的依赖范围有如下6种：
> * compile： 默认编译依赖范围。对于编译，测试，运行三种classpath都有效
> * test：测试依赖范围。只对于测试classpath有效
> * provided：已提供依赖范围。对于编译，测试的classpath都有效，但对于运行无效。因为由容器已经提供，例如servlet-api
> * runtime：运行时提供。例如:jdbc驱动
> * system：系统范围,自定义构件，指定systemPath；跟provided 相似，但是在系统中要以外部JAR包的形式提供，maven不会在repository查找它。
> * import：只使用在<dependencyManagement>中，表示从其它的pom中导入dependency的配置。
* 2\.传递依赖：若C依赖B，B依赖A，那么称C对B是第一直接依赖，B对A是第二直接依赖，c对A是传递依赖。
* 3\.向下传递：<optional>true</optional>在这里默认值为true此时不向下传递，false则向下传递
* 4\.依赖冲突：直接与间接依赖中包含有同一个坐标不同版本的资源依赖，以直接依赖的版本为准（就近原则）
* 5\.排除依赖：若c依赖b，b依赖a，那么c若不想依赖于a时，可使用<exclusions>接触依赖，
```
 <exclusions>
<!-- 排除spring-core的传递依赖 -->
<exclusion>
<groupId>org.springframework</groupId>
<artifactId>spring-core</artifactId>
</exclusion>
</exclusions>
```
	
# 五、maven生命周期
* 1\.Maven定义了三套生命周期：clean、default、site，每个生命周期都包含了一些阶段（phase）。三套生命周期相互独立，但各个生命周期中的phase却是有顺序的，且后面的phase依赖于前面的phase。执行某个phase时，其前面的phase会依顺序执行，但不会触发另外两套生命周期中的任何phase。
> * Clean Lifecycle 在进行真正的构建之前进行一些清理工作。 
> * Default Lifecycle 构建的核心部分，编译，测试，打包，部署等等。 
> * Site Lifecycle 生成项目报告，站点，发布站点。 
* 1.1 clean生命周期
> * pre-clean:执行清理前的工作；
> * clean:清理上一次构建生成的所有文件；
> * post-clean:执行清理后的工作
* 1.2 default生命周期
> * default生命周期是最核心的，它包含了构建项目时真正需要执行的所有步骤。
> * validate
> * initialize
> * generate-sources
> * process-sources
> * generate-resources
> * process-resources:复制和处理资源文件到target目录，准备打包；
> * compile:编译项目的源代码；
> * process-classes
> * generate-test-sources
> * process-test-sources
> * generate-test-resources
> * process-test-resources
> * test-compile:编译测试源代码；
> * process-test-classes
> * test:运行测试代码；
> * prepare-package
> * package:;打包成jar或者war或者其他格式的分发包；
> * pre-integration-test
> * integration-test
> * post-integration-test
> * verify
> * install:将打好的包安装到本地仓库，供其他项目使用；
> * deploy:将打好的包安装到远程仓库，供其他项目使用；
* 1.3 site生命周期
> * pre-site
> * site:生成项目的站点文档；
> * post-site
> * site-deploy:发布生成的站点文档
# 六、maven插件
* 1\.Maven的核心仅仅定义了抽象的生命周期，具体的任务都是交由插件完成的。一个插件通常可以完成多个任务，每一个任务就叫做插件的一个目标。Maven的生命周期与插件目标相互绑定，以完成某个具体的构建任务。
> * 将插件的目标（goal）绑定到生命周期的具体阶段（phase）
> * ![插件](https://images0.cnblogs.com/i/293735/201407/012039514021164.png)
* 2\.内置绑定：Maven对一些生命周期的阶段（phase）默认绑定了插件目标，因为不同的项目有jar、war、pom等不同的打包方式，因此对应的有不同的绑定关系，其中针对default生命周期的jar包打包方式的绑定关系如下：
> * ![内置绑定](https://images0.cnblogs.com/i/293735/201407/012040407939185.png)
* 3\.自定义绑定:
```
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-source-plugin</artifactId>
            <version>2.2.1</version>
            <executions>
                <execution>
                    <id>attach-source</id>
                    <phase>package</phase><!-- 要绑定到的生命周期的阶段 -->
                    <goals>
                        <goal>jar-no-fork</goal><!-- 要绑定的插件的目标 -->
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
    ……
</build>
```
* 4\.插件仓库：
> * 跟其他构件一样，插件也是根据坐标存储在Maven仓库中。超级POM中Maven配置的默认插件远程仓库如下：
```
<pluginRepositories>
    <pluginRepository>
      <id>central</id>
      <name>Central Repository</name>
      <url>http://repo.maven.apache.org/maven2</url>
      <layout>default</layout>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
      <releases>
        <updatePolicy>never</updatePolicy>
      </releases>
    </pluginRepository>
</pluginRepositories>
```
# 七、maven继承

* 1\. 继承为了消除重复，可以把pom中很多相同的配置提取出来；如：grouptId，version等。在使用的时候子工程直接继承父工程的依赖版本号，子工程中不再需要指定具体版本号，方便统一管控项目的依赖版本问题。
> *父工程的pom.xml中的打包方式必须设置为pom方式:
```
<!-- 父工程 -->
	<parent>
		<groupId>cn.sm1234</groupId>
		<artifactId>parent</artifactId>
		<version>0.0.1-SNAPSHOT</version>
	</parent>
```
* 2\.聚合：如果想一次构建多个项目模块，那则需要对多个项目模块进行聚合
```
<modules>
    <module>../子项目名称1</module>
    <module>../子项目名称2</module>
     <module>../子项目名称3</module>
</modules>
```
# 八.maven常用命令

命令参数|详情
-|-:
mvn -v	|--version 显示版本信息;
mvn -V	|--show-version 显示版本信息后继续执行Maven其他目标;
mvn -h	|--help 显示帮助信息;
mvn -e	|--errors 控制Maven的日志级别,产生执行错误相关消息;
mvn -X	|--debug 控制Maven的日志级别,产生执行调试信息;
mvn -q	|--quiet 控制Maven的日志级别,仅仅显示错误;
mvn -Pxxx 	|激活 id 为 xxx的profile (如有多个，用逗号隔开);
mvn -Dxxx=yyy	| 指定Java全局属性;
mvn -o	|--offline 运行offline模式,不联网更新依赖;
mvn -N	|--non-recursive 仅在当前项目模块执行命令,不构建子模块;
mvn -pl	|--module_name 在指定模块上执行命令;
mvn -ff	|--fail-fast 遇到构建失败就直接退出;
mvn -fn	|--fail-never 无论项目结果如何,构建从不失败;
mvn -fae	|--fail-at-end 仅影响构建结果,允许不受影响的构建继续;
mvn -C	|--strict-checksums 如果校验码不匹配的话,构建失败;
mvn -c	|--lax-checksums 如果校验码不匹配的话,产生告警;
mvn -U	|强制更新snapshot类型的插件或依赖库(否则maven一天只会更新一次snapshot依赖);
mvn -npu	|--no-plugin-s 对任何相关的注册插件,不进行最新检查(使用该选项使Maven表现出稳定行为，该稳定行为基于本地仓库当前可用的所有插件版本);
mvn -cpu	|--check-plugin-updates 对任何相关的注册插件,强制进行最新检查(即使项目POM里明确规定了Maven插件版本,还是会强制更新);
mvn -up	|--update-plugins [mvn -cpu]的同义词;
mvn -B	|--batch-mode 在非交互（批处理）模式下运行(该模式下,当Mven需要输入时,它不会停下来接受用户的输入,而是使用合理的默认值);
mvn -f	|--file <file> 强制使用备用的POM文件;
mvn -s	|--settings <arg> 用户配置文件的备用路径;
mvn -gs	|--global-settings <file> 全局配置文件的备用路径;
mvn -emp	|--encrypt-master-password <password> 加密主安全密码,存储到Maven settings文件里;
mvn -ep	|--encrypt-password <password> 加密服务器密码,存储到Maven settings文件里;
mvn -npr	|--no-plugin-registry 对插件版本不使用~/.m2/plugin-registry.xml(插件注册表)里的配置;
