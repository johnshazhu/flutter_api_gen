# ivybaby_api_example

Demonstrates how to use the ivybaby_api plugin.

## Getting Started
切换到example目录
    flutter clean
    flutter pub get
    flutter packages pub run build_runner build --delete-conflicting-outputs
依次执行上面的命令，可在util下发现生成的.impls.dart文件

例子中提供了三种生成接口文件的方式
1、所有使用@Api注解的方法，对应实现都合并在一个文件中。(接口多时，文件会越来越大)
2、使用@Api注解的方法，对应实现按模块生成在指定的文件中。
3、使用@Api注解的方法，对应实现按baseUrl生成在不同的文件中
