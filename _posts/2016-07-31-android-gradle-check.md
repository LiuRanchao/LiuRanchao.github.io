---
layout: post
title: Android集成Gradle代码检查
tags:
- 代码检查
categories: Android
description: 使用Gradle集成代码检查，PMD,FindBugs,CheckStyle,Lint
---

# PMD

__quality.gradle文件__

~~~ gradle
apply plugin: 'checkstyle'
apply plugin: 'findbugs'
apply plugin: 'pmd'

// Add checkstyle, findbugs, pmd and lint to the check task.
check.dependsOn 'checkstyle', 'findbugs', 'pmd', 'lint'

/**
 * PMD
 */
task pmd(type: Pmd) {
    ignoreFailures = false
    ruleSetFiles = files("${project.rootDir}/app/config/quality/pmd/pmd-ruleset.xml")
    ruleSets = []

    source 'src'
    include '**/*.java'
    exclude '**/gen/**',
            "androidTest/**",
            "debug/**",
            "test/**",
            "main/java/com/jia/zxpt/user/ui/fragment/decorate_security/DecorateSecurityFragment.java"

    reports {
        xml.enabled = false
        html.enabled = true
        xml {
            destination "$project.buildDir/reports/pmd/pmd.xml"
        }
        html {
            destination "$project.buildDir/reports/pmd/pmd.html"
        }
    }
}
~~~

__pmd-ruleset.xml文件__

```
<?xml version="1.0"?>
<!--
  ~ Copyright 2015 Vincent Brison.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

<ruleset name="Android Application Rules" xmlns="http://pmd.sf.net/ruleset/1.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://pmd.sf.net/ruleset_xml_schema.xsd"
         xsi:schemaLocation="http://pmd.sf.net/ruleset/1.0.0 http://pmd.sf.net/ruleset_xml_schema.xsd">

    <description>Custom ruleset for Android application</description>

    <exclude-pattern>.*/R.java</exclude-pattern>
    <exclude-pattern>.*/gen/.*</exclude-pattern>

    <rule ref="rulesets/java/logging-java.xml">
        <exclude name="AvoidPrintStackTrace"/>
    </rule>

    <rule ref="rulesets/java/strings.xml">
        <exclude name="InsufficientStringBufferDeclaration"/>
        <exclude name="ConsecutiveAppendsShouldReuse"/>
        <exclude name="AppendCharacterWithChar"/>
        <exclude name="AvoidStringBufferField"/>
        <exclude name="ConsecutiveLiteralAppends"/>
        <exclude name="AvoidDuplicateLiterals"/>
        <exclude name="InefficientStringBuffering"/>
    </rule>

    <rule ref="rulesets/java/android.xml"/>

    <rule ref="rulesets/java/clone.xml"/>

    <rule ref="rulesets/java/finalizers.xml"/>

    <rule ref="rulesets/java/imports.xml">
        <exclude name="TooManyStaticImports"/>
    </rule>

    <rule ref="rulesets/java/braces.xml"/>

    <rule ref="rulesets/java/basic.xml">
        <exclude name="DoubleCheckedLocking"/>
        <exclude name="CollapsibleIfStatements"/>
    </rule>

    <rule ref="rulesets/java/naming.xml">
        <!-- 类名少于5个字符 -->
        <exclude name="ShortClassName"/>
        <!-- 变量名太长 -->
        <exclude name="LongVariable"/>
        <exclude name="AbstractNaming"/>
        <exclude name="LongVariable"/>
        <exclude name="ShortMethodName"/>
        <exclude name="ShortVariable"/>
        <!--<exclude name="VariableNamingConventions"/>-->
    </rule>

</ruleset>
```

#FindBugs

__findbugs-filter.xml__

```
<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright 2015 Vincent Brison.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

<FindBugsFilter>
    <!-- http://stackoverflow.com/questions/7568579/eclipsefindbugs-exclude-filter-files-doesnt-work -->
    <Match>
        <Class name="~.*\.R\$.*"/>
    </Match>

    <Match>
        <Class name="~.*\.Manifest\$.*"/>
    </Match>
    <!-- All bugs in test classes, except for JUnit-specific bugs -->
    <Match>
        <Class name="~.*\.*Test"/>
        <Not>
            <Bug code="IJU"/>
        </Not>
    </Match>

    <!-- 不检查返回值的使用问题 -->
    <Match>
        <Bug pattern="RV_RETURN_VALUE_IGNORED"/>
    </Match>

    <Match>
        <Class name="~.*\.*Application"/>
        <Bug pattern="DM_GC"/>
    </Match>

    <Match>
        <Class name="~.*\.*Application"/>
        <Bug pattern="ST_WRITE_TO_STATIC_FROM_INSTANCE_METHOD"/>
    </Match>

</FindBugsFilter>
```

__quality.gradle文件__

```
/**
 * findBugs
 */
task findbugs(type: FindBugs, dependsOn: assembleDebug) {
    ignoreFailures = false
    effort = "max"
    reportLevel = "high"
    excludeFilter = new File("${project.rootDir}/app/config/quality/findbugs/findbugs-filter.xml")
    classes = files("${project.rootDir}/app/build/intermediates/classes")

    source 'src'
    include '**/*.java'
    exclude '**/gen/**',
            "androidTest/**",
            "debug/**",
            "test/**"

    reports {
        xml.enabled = false
        html.enabled = true
        xml {
            destination "$project.buildDir/reports/findbugs/findbugs.xml"
        }
        html {
            destination "$project.buildDir/reports/findbugs/findbugs.html"
        }
    }

    classpath = files()
}
```

#CheckStyle

__quality.gradle文件__

```
apply plugin: 'checkstyle'
apply plugin: 'findbugs'


// Add checkstyle, findbugs, pmd and lint to the check task.
check.dependsOn 'checkstyle', 'findbugs', 'lint'

task checkstyle(type: Checkstyle) {
    configFile file("${project.rootDir}/app/config/quality/checkstyle/checkstyle.xml")
    configProperties.checkstyleSuppressionsPath = file("${project.rootDir}/app/config/quality/checkstyle/suppressions.xml").absolutePath
    source 'src'
    include '**/*.java'
    exclude '**/gen/**',
            "androidTest/**",
            "debug/**",
            "test/**",
            "main/java/com/jia/zxpt/user/ui/widget/**",
            "main/java/com/jia/zxpt/user/ui/activity/rongcloud/**",
            "main/java/com/jia/zxpt/user/ui/fragment/decorate_security/DecorateSecurityFragment.java"
    classpath = files()
}
```

__checkstyle.xml文件__

```
<?xml version="1.0"?>
<!DOCTYPE module PUBLIC
    "-//Puppy Crawl//DTD Check Configuration 1.3//EN"
    "http://www.puppycrawl.com/dtds/configuration_1_3.dtd">

<module name="Checker">

    <property name="charset" value="UTF-8"/>

    <!-- 检查文件的长度（行） default max=500 -->
    <module name="FileLength">
        <property name="max" value="800"/>
    </module>

    <!-- ============================== -->
    <!-- ==============行数检查============== -->
    <!-- ============================== -->
    <module name="TreeWalker">

        <!-- 必须导入类的完整路径，即不能使用*导入所需的类 -->
        <module name="AvoidStarImport"/>

        <!-- 检查是否从非法的包中导入了类 illegalPkgs: 定义非法的包名称-->
        <module name="IllegalImport"/> <!-- defaults to sun.* packages -->

        <!-- 检查是否导入了不必显示导入的类-->
        <module name="RedundantImport"/>


        <!--option: 定义左大括号'{'显示位置，eol在同一行显示，nl在下一行显示
          maxLineLength: 大括号'{'所在行行最多容纳的字符数
          tokens: 该属性适用的类型，例：CLASS_DEF,INTERFACE_DEF,METHOD_DEF,CTOR_DEF -->
        <module name="LeftCurly">
            <property name="option" value="eol"/>
        </module>

        <!-- NeedBraces 检查是否应该使用括号的地方没有加括号
          tokens: 定义检查的类型 -->
        <module name="NeedBraces"/>

        <module name="RightCurly">
            <property name="option" value="alone"/>
            <property name="tokens" value="LITERAL_ELSE, METHOD_DEF"/>
        </module>

        <!-- packages -->
        <module name="PackageName">
            <!--<property name="format" value="^[a-z]+(\.[a-z][a-z0-9]*)*$"/>-->
        </module>

        <module name="HideUtilityClassConstructor"/>

        <!-- Checks the style of array type definitions. Some like Java-style: public static void main(String[] args) and some like C-style: public static void main(String args[])
          检查再定义数组时，采用java风格还是c风格，例如：int[] num是java风格，int num[]是c风格。默认是java风格-->
        <module name="ArrayTypeStyle"/>

        <!-- Checks that there are no "magic numbers", where a magic number is a numeric literal that is not defined as a constant. By default, -1, 0, 1, and 2 are not considered to be magic numbers. -->
        <!--<module name="MagicNumber"/>-->

        <!--  Checks that long constants are defined with an upper ell. That is ' L' and not 'l'. This is in accordance to the Java Language Specification,  Section 3.10.1.
          检查是否在long类型是否定义了大写的L.字母小写l和数字1（一）很相似。
          looks a lot like 1. -->
        <module name="UpperEll"/>

        <!-- Checks the number of parameters of a method or constructor. max default 7个. -->
        <module name="ParameterNumber">
            <property name="max" value="7"/>
            <property name="tokens" value="METHOD_DEF, CTOR_DEF"/>
        </module>

        <!-- 每行字符数 -->
        <module name="LineLength">
            <property name="max" value="140"/>
        </module>

        <!-- if-else嵌套语句个数 最多4层 -->
        <module name="NestedIfDepth">
            <property name="max" value="3"/>
        </module>

        <!-- try-catch 嵌套语句个数 最多2层 -->
        <module name="NestedTryDepth">
            <property name="max" value="2"/>
        </module>

        <!-- 返回个数 -->
        <module name="ReturnCount">
            <property name="max" value="5"/>
            <property name="format" value="^$"/>
        </module>

        <!-- Checks the number of methods declared in each type. This includes the number of each scope !-->
        <!-- (private, package, protected and public) as well as an overall total. !-->
        <!-- See http://checkstyle.sourceforge.net/config_sizes.html#MethodCount !-->
        <module name="MethodCount">
            <property name="maxTotal" value="100"/>
            <property name="maxPrivate" value="100"/>
            <property name="maxPackage" value="100"/>
            <property name="maxProtected" value="100"/>
            <property name="maxPublic" value="100"/>
        </module>

        <!-- Checks for long methods and constructors. !-->
        <!-- See http://checkstyle.sf.net/config_sizes.html !-->
        <module name="MethodLength">
            <property name="max" value="200"/>
            <property name="countEmpty" value="true"/>
            <property name="tokens" value="METHOD_DEF, CTOR_DEF"/>
        </module>

        <!-- Checks for the number of types declared at the outer (or root) level in a file. !-->
        <!-- See http://checkstyle.sourceforge.net/config_sizes.html#OuterTypeNumber !-->
        <module name="OuterTypeNumber">
            <property name="max" value="1"/>
        </module>

    </module>

    <!-- ============================== -->
    <!-- ==============排版检查============== -->
    <!-- ============================== -->
    <module name="TreeWalker">
        <!-- Checks for whitespace -->
        <module name="EmptyForIteratorPad">
            <property name="option" value="nospace"/>
        </module>
        <!-- Checks that there is no whitespace after a token. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="NoWhitespaceAfter">
            <property name="allowLineBreaks" value="true"/>
            <property name="tokens"
                      value="ARRAY_INIT, BNOT, DEC, DOT, INC, LNOT, UNARY_MINUS, UNARY_PLUS"/>
        </module>
        <!-- Checks that there is no whitespace before a token. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="NoWhitespaceBefore">
            <property name="allowLineBreaks" value="false"/>
            <property name="tokens" value="SEMI, POST_DEC, POST_INC"/>
        </module>
        <!-- Checks the policy on how to wrap lines on operators. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="OperatorWrap">
            <property name="option" value="eol"/>
            <property name="tokens" value="ASSIGN, BAND, BOR, BSR, BXOR, COLON, DIV,
                                           EQUAL, GE, GT, LAND, LE, LITERAL_INSTANCEOF,
                                           LOR, LT, MINUS, MOD, NOT_EQUAL,
                                           PLUS, QUESTION, SL, SR, STAR"/>
        </module>
        <!-- Checks the policy on the padding of parentheses. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="ParenPad">
            <property name="option" value="nospace"/>
            <property name="tokens"
                      value="CTOR_CALL, LPAREN, METHOD_CALL, RPAREN, SUPER_CTOR_CALL"/>
        </module>
        <!-- Checks the policy on the padding of parentheses for typecasts. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="TypecastParenPad">
            <property name="option" value="nospace"/>
            <property name="tokens" value="TYPECAST, RPAREN"/>
        </module>

        <!-- Checks that a token is surrounded by whitespace. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="WhitespaceAround">
            <property name="tokens" value="ASSIGN, BAND, BAND_ASSIGN, BOR, BOR_ASSIGN, BSR, BSR_ASSIGN,
                                           BXOR, BXOR_ASSIGN, COLON, DIV, DIV_ASSIGN, EQUAL, GE, GT, LAND,
                                           LCURLY, LE, LITERAL_ASSERT, LITERAL_CATCH, LITERAL_DO, LITERAL_ELSE,
                                           LITERAL_FINALLY, LITERAL_FOR, LITERAL_IF, LITERAL_RETURN,
                                           LITERAL_SYNCHRONIZED, LITERAL_TRY, LITERAL_WHILE, LOR, LT,
                                           MINUS, MINUS_ASSIGN, MOD, MOD_ASSIGN, NOT_EQUAL, PLUS, PLUS_ASSIGN,
                                           QUESTION, RCURLY, SL, SLIST, SL_ASSIGN, SR, SR_ASSIGN, STAR, STAR_ASSIGN"/>
            <property name="allowEmptyConstructors" value="false"/>
            <property name="allowEmptyMethods" value="false"/>
        </module>

        <!-- Checks the padding of an empty for initializer. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="EmptyForInitializerPad">
            <property name="option" value="nospace"/>
        </module>

        <!-- Checks that the whitespace around the Generic tokens < and > is correct to the typical convention. !-->
        <!-- See http://checkstyle.sourceforge.net/config_whitespace.html#GenericWhitespace !-->
        <module name="GenericWhitespace"/>

        <!-- Checks the padding between the identifier of a method definition, !-->
        <!-- constructor definition, method call, or constructor invocation; and the left parenthesis of the parameter list. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="MethodParamPad">
            <property name="allowLineBreaks" value="false"/>
            <property name="option" value="nospace"/>
            <property name="tokens"
                      value="CTOR_DEF, LITERAL_NEW, METHOD_CALL, METHOD_DEF, SUPER_CTOR_CALL "/>
        </module>

        <!-- Checks that a token is followed by whitespace. !-->
        <!-- See http://checkstyle.sf.net/config_whitespace.html !-->
        <module name="WhitespaceAfter">
            <property name="tokens" value="COMMA, SEMI, TYPECAST"/>
        </module>

        <!-- The following checks are actually not whitespace checks, but still fit here quite well. !-->

        <!-- Checks that there is only one statement per line. !-->
        <!-- See http://checkstyle.sourceforge.net/config_coding.html#OneStatementPerLine !-->
        <module name="OneStatementPerLine"/>

        <!-- Checks that each variable declaration is in its own statement and on its own line. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="MultipleVariableDeclarations"/>
    </module>

    <!-- Checks that there are no tabs in the source file !-->
    <!-- http://checkstyle.sourceforge.net/config_whitespace.html#FileTabCharacter !-->
    <module name="FileTabCharacter"/>

    <!-- ============================== -->
    <!-- ==============命名检查============== -->
    <!-- ============================== -->
    <module name="TreeWalker">
        <!-- Checks that the outer type name and the file name match. !-->
        <!-- See http://checkstyle.sourceforge.net/config_misc.html#OuterTypeFilename !-->
        <module name="OuterTypeFilename"/>

        <!-- Checks for class type parameter name naming conventions. !-->
        <!-- See http://checkstyle.sourceforge.net/config_naming.html#ClassTypeParameterName !-->
        <module name="ClassTypeParameterName">
            <property name="format" value="^[A-Z]$"/>
        </module>

        <!-- Checks for constant name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="ConstantName">
            <property name="format" value="^[A-Z][A-Z0-9]*(_[A-Z0-9]+)*$"/>
            <property name="applyToPublic" value="true"/>
            <property name="applyToProtected" value="true"/>
            <property name="applyToPackage" value="true"/>
            <property name="applyToPrivate" value="true"/>
        </module>

        <!-- Checks for local final variable name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="LocalFinalVariableName">
            <property name="format" value="^[a-z][a-zA-Z0-9]*$"/>
            <property name="tokens" value="VARIABLE_DEF, PARAMETER_DEF"/>
        </module>

        <!-- Checks for local variable name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="LocalVariableName">
            <property name="format" value="^[a-z][a-zA-Z0-9]*$"/>
            <property name="tokens" value="VARIABLE_DEF, PARAMETER_DEF"/>
        </module>

        <!-- Checks for member variable name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <!-- 成员变量名 检查 -->
        <module name="MemberName">
            <property name="format" value="^m[A-Z][a-zA-Z0-9]*$"/>
            <property name="applyToPublic" value="true"/>
            <property name="applyToProtected" value="true"/>
            <property name="applyToPackage" value="true"/>
            <property name="applyToPrivate" value="true"/>
        </module>

        <!-- Checks for method name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="MethodName">
            <property name="format" value="^[a-z][a-zA-Z0-9]*$"/>
            <property name="applyToPublic" value="true"/>
        </module>

        <!-- Checks for method type parameter name naming conventions. !-->
        <!-- See http://checkstyle.sourceforge.net/config_naming.html#MethodTypeParameterName !-->
        <module name="MethodTypeParameterName">
            <property name="format" value="^[A-Z]$"/>
        </module>

        <!-- Checks for package name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="PackageName">
            <property name="format" value="^[a-z][a-z0-9]*(\.[a-zA-Z_][a-zA-Z0-9_]*)*$"/>
        </module>

        <!-- Checks for parameter name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <!-- 参数名检查 -->
        <module name="ParameterName">
            <property name="format" value="^[a-z][a-zA-Z0-9]*$"/>
        </module>

        <!-- Checks for static variable name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="StaticVariableName">
            <property name="format" value="^[a-z][a-zA-Z0-9]*$"/>
            <property name="applyToPublic" value="true"/>
            <property name="applyToProtected" value="true"/>
            <property name="applyToPackage" value="true"/>
            <property name="applyToPrivate" value="true"/>
        </module>

        <!-- Checks for type name naming conventions. !-->
        <!-- See http://checkstyle.sf.net/config_naming.html !-->
        <module name="TypeName">
            <property name="format" value="^[A-Z][a-zA-Z0-9]*$"/>
            <property name="tokens" value="CLASS_DEF, INTERFACE_DEF"/>
            <property name="applyToPublic" value="true"/>
            <property name="applyToProtected" value="true"/>
            <property name="applyToPackage" value="true"/>
            <property name="applyToPrivate" value="true"/>
        </module>
    </module>

    <!-- ============================== -->
    <!-- ==============文档检查============== -->
    <!-- ============================== -->
    <module name="TreeWalker">
        <!-- Validates Javadoc comments to help ensure they are well formed. !-->
        <!-- See http://checkstyle.sf.net/config_javadoc.html#JavadocStyle !-->
        <module name="JavadocStyle">
            <property name="scope" value="private"/>
            <!--
            <property name="excludeScope"        value=""/>
            !-->
            <property name="checkFirstSentence" value="false"/>
            <property name="endOfSentenceFormat" value="([.?!][ \t\n\r\f&lt;])|([.?!]$)"/>
            <property name="checkEmptyJavadoc" value="false"/>
            <property name="checkHtml" value="true"/>
            <property name="tokens"
                      value="INTERFACE_DEF, CLASS_DEF, METHOD_DEF, CTOR_DEF, VARIABLE_DEF"/>
        </module>

        <!-- 检查类和接口的javadoc 默认不检查author 和version tags
            authorFormat: 检查author标签的格式
        versionFormat: 检查version标签的格式
        scope: 可以检查的类的范围，例如：public只能检查public修饰的类，private可以检查所有的类
        excludeScope: 不能检查的类的范围，例如：public，public的类将不被检查，但访问权限小于public的类仍然会检查，其他的权限以此类推
        tokens: 该属性适用的类型，例如：CLASS_DEF,INTERFACE_DEF -->
        <!--<module name="JavadocType">-->
        <!--<property name="authorFormat" value="\S"/>-->
        <!--<property name="scope" value="protected"/>-->
        <!--<property name="tokens" value="CLASS_DEF,INTERFACE_DEF"/>-->
        <!--<property name="allowUnknownTags" value="true"/>-->
        <!--</module>-->

        <!-- 检查方法的javadoc的注释
       scope: 可以检查的方法的范围，例如：public只能检查public修饰的方法，private可以检查所有的方法
       allowMissingParamTags: 是否忽略对参数注释的检查
       allowMissingThrowsTags: 是否忽略对throws注释的检查
       allowMissingReturnTag: 是否忽略对return注释的检查 -->
        <!--<module name="JavadocMethod">-->
        <!--<property name="scope" value="protected"/>-->
        <!--<property name="allowMissingParamTags" value="false"/>-->
        <!--<property name="allowMissingThrowsTags" value="false"/>-->
        <!--<property name="allowMissingReturnTag" value="true"/>-->
        <!--<property name="tokens" value="METHOD_DEF"/>-->
        <!--<property name="allowUndeclaredRTE" value="true"/>-->
        <!--<property name="allowThrowsTagsForSubclasses" value="true"/>-->
        <!--&lt;!&ndash;允许get set 方法没有注释&ndash;&gt;-->
        <!--<property name="allowMissingPropertyJavadoc" value="true"/>-->
        <!--</module>-->

        <!-- 检查类变量的注释
                scope: 检查变量的范围，例如：public只能检查public修饰的变量，private可以检查所有的变量 -->
        <!--<module name="JavadocVariable">-->
        <!--<property name="scope" value="protected"/>-->
        <!--</module>-->

    </module>

    <!-- ============================== -->
    <!-- ============================ -->
    <!-- ============================== -->
    <module name="TreeWalker">
        <!-- Ensure a class has a package declaration. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="PackageDeclaration">
            <property name="ignoreDirectoryName" value="true"/>
        </module>

    </module>

    <!-- ============================== -->
    <!-- ============================ -->
    <!-- ============================== -->
    <module name="TreeWalker">
        <!-- Checks visibility of class members. !-->
        <!-- See http://checkstyle.sf.net/config_design.html !-->
        <!--<module name="VisibilityModifier">-->
        <!--<property name="packageAllowed" value="false"/>-->
        <!--<property name="protectedAllowed" value="true"/>-->
        <!--<property name="publicMemberPattern" value="^serialVersionUID$"/>-->
        <!--</module>-->

        <!-- Checks that classes (except abtract one) define a ctor and don't rely on the default one. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <!--<module name="MissingCtor"/>!-->

        <!-- Make sure that utility classes (classes that contain only static methods) do not have a public constructor. !-->
        <!-- See http://checkstyle.sf.net/config_design.html !-->
        <module name="HideUtilityClassConstructor"/>

    </module>

    <!-- ============================== -->
    <!-- ============================ -->
    <!-- ============================== -->
    <module name="TreeWalker">
        <!-- ModifierOrder 检查修饰符的顺序，默认是 public,protected,private,abstract,static,final,transient,volatile,synchronized,native -->
        <module name="ModifierOrder"/>

        <!-- Checks that a class which has only private constructors is declared as final.只有私有构造器的类必须声明为final-->
        <module name="FinalClass"/>

        <!-- Check nested (internal) classes/interfaces are declared at the bottom of the class after all method and field declarations. !-->
        <!-- See http://checkstyle.sourceforge.net/config_design.html#InnerTypeLast !-->
        <module name="InnerTypeLast"/>

        <!-- Implements Bloch, Effective Java, Item 17 - Use Interfaces only to define types. !-->
        <!-- See http://checkstyle.sf.net/config_design.html !-->
        <!--<module name="InterfaceIsType">-->
        <!--<property name="allowMarkerInterfaces" value="true"/>-->
        <!--</module>-->

        <!-- Restricts throws statements to a specified count. !-->
        <!-- See http://checkstyle.sf.net/config_design.html !-->
        <module name="ThrowsCount">
            <property name="max" value="2"/>
        </module>

        <!-- Checks that classes that define a covariant equals() method also override method equals(java.lang.Object). !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="CovariantEquals"/>

        <!-- Checks declaration order according to Code Conventions for the Java Programming Language. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <!--<module name="DeclarationOrder">-->
        <!--<property name="ignoreConstructors" value="true"/>-->
        <!--<property name="ignoreMethods" value="true"/>-->
        <!--<property name="ignoreModifiers" value="true"/>-->
        <!--</module>-->

        <!-- Check that the default is after all the cases in a switch statement. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="DefaultComesLast"/>

        <!-- Detects empty statements (standalone ;). !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="EmptyStatement"/>

        <!-- Catching java.lang.Exception, java.lang.Error or java.lang.RuntimeException is almost never acceptable. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="IllegalCatch">
            <property name="illegalClassNames"
                      value="java.lang.Throwable, java.lang.RuntimeException"/>
        </module>

        <!-- This check can be used to ensure that types are not declared to be thrown. !-->
        <!-- Declaring to throw java.lang.Error or java.lang.RuntimeException is almost never acceptable. !-->
        <!-- See http://checkstyle.sourceforge.net/config_coding.html#IllegalThrows !-->
        <module name="IllegalThrows">
            <property name="illegalClassNames"
                      value="java.lang.Throwable, java.lang.Error, java.lang.RuntimeException"/>
        </module>

        <!-- Checks for assignments in subexpressions, such as in String s = Integer.toString(i = 2);. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="InnerAssignment">
            <property name="tokens" value="ASSIGN, BAND_ASSIGN, BOR_ASSIGN, BSR_ASSIGN, BXOR_ASSIGN,
                                           DIV_ASSIGN, MINUS_ASSIGN, MOD_ASSIGN, PLUS_ASSIGN, SL_ASSIGN,
                                           SR_ASSIGN, STAR_ASSIGN"/>
        </module>

        <!--  Checks that switch statement has "default" clause. 检查switch语句是否有‘default’从句
        Rationale: It's usually a good idea to introduce a default case in every switch statement.
        Even if the developer is sure that all currently possible cases are covered, this should be expressed in the default branch,
        e.g. by using an assertion. This way the code is protected aginst later changes, e.g. introduction of new types in an enumeration type. -->
        <module name="MissingSwitchDefault"/>

        <!-- Check for ensuring that for loop control variables are not modified inside the for block. !-->
        <!-- See http://checkstyle.sourceforge.net/config_coding.html#ModifiedControlVariable !-->
        <module name="ModifiedControlVariable"/>

        <!-- Disallow assignment of parameters. !-->
        <!-- See http://checkstyle.sf.net/config_coding.html !-->
        <module name="ParameterAssignment"/>

        <!-- this got moved here from the import checks !-->
        <!-- Checks for unused import statements. !-->
        <!-- See http://checkstyle.sf.net/config_import.html !-->
        <module name="UnusedImports"/>

        <!-- 检查是否有多余的修饰符，例如：接口中的方法不必使用public、abstract修饰  -->
        <module name="RedundantModifier"/>

        <!--- 字符串比较必须使用 equals() -->
        <module name="StringLiteralEquality"/>
    </module>

</module>
```

#Lint

__guality.gradle__

```
apply plugin: 'checkstyle'

// Add checkstyle, findbugs, pmd and lint to the check task.
check.dependsOn 'checkstyle', 'lint'

android {
    lintOptions {
        abortOnError true
        xmlReport false
        htmlReport true
        lintConfig file("${project.rootDir}/app/config/quality/lint/lint.xml")
        htmlOutput file("$project.buildDir/reports/lint/lint-result.html")
        xmlOutput file("$project.buildDir/reports/lint/lint-result.xml")
    }
}
```

__lint.xml文件__

```
<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright 2015 Vincent Brison.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

<lint>

    <!-- We used -->
    <issue id="OnClick" severity="error"/>
    <issue id="MissingPermission" severity="error"/>
    <issue id="MissingSuperCall" severity="error"/>
    <issue id="AndroidGradlePluginVersion" severity="error"/>
    <issue id="GradleCompatible" severity="error"/>
    <issue id="MissingRegistered" severity="error"/>
    <issue id="StringShouldBeInt" severity="error"/>
    <issue id="DalvikOverride" severity="error"/>
    <issue id="ResourceAsColor" severity="error"/>
    <issue id="WebViewLayout" severity="error"/>
    <issue id="DuplicateDefinition" severity="error"/>
    <issue id="GradleGetter" severity="error"/>
    <issue id="InvalidResourceFolder" severity="error"/>
    <issue id="MissingPrefix" severity="error"/>
    ...
    ...
    ...
</lint>
```

#参考
[PMD规则](http://pmd.sourceforge.net/pmd-4.3.0/rules/)  
[http://findbugs.sourceforge.net/bugDescriptions.html]()   
[http://findbugs.sourceforge.net/manual/filter.html]()   
[http://www.ibm.com/developerworks/library/j-findbug1/]()   
[http://blog.csdn.net/mike_caoyong/article/details/6746911]()      
[http://checkstyle.sourceforge.net/config_coding.html]()    
[CheckStyle Demo](https://github.com/vincentbrison/vb-android-app-quality/blob/master/config/quality/checkstyle/checkstyle.xml)   
[https://github.com/checkstyle/checkstyle/blob/master/config/checkstyle_checks.xml]()     
[http://developer.android.com/intl/zh-cn/tools/debugging/improving-w-lint.html]()    
[http://tools.android.com/tips/lint]()    
[http://tools.android.com/tips/lint-checks]()    
[http://tools.android.com/tips/lint/suppressing-lint-warnings]()    
[http://hubingforever.blog.163.com/blog/static/17104057920121069261691/]()   
[http://blog.csdn.net/hudashi/article/details/8333650]()
