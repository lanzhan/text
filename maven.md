# 一、maven类似于jar包管理工具，它可以解决以下问题：
##
* 1\.解决jar包冲突。
* 2\.jar依赖
* 3\.jar文件不用在每个项目保存，只需要放在仓库即可
* 4\.maven可以指定jar的依赖范围
# 二、maven坐标:主要由三部分组成，分别是groupId、artifactId、version简称GAV
##
* 1\.groupId是项目组织唯一的标识符，实际对应包的结构
* 2\.artifactID就是项目的唯一的标识符，实际对应项目的名称
* 3\.version版本号
* 4\.packaging定义了该项目的打包方式，一般为jar可有可无

...
 <groupId>com.example</groupId>
 <artifactId>demo</artifactId>
 <version>0.0.1-SNAPSHOT</version>
 <packaging>jar</packaging>
...
