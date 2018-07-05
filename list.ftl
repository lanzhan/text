<#import "/spring.ftl" as s>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="utf-8">
    <title>学生用户列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <#include '../include/baselink.ftl'>
    <link rel="stylesheet" type="text/css" href="<@s.url '/assets/css/jquery.pagination.css'/>">
</head>

<body class="dashboard-page">

<div id="userList">
    <nav style="background-color:#f5f5f5;padding:0 20px;border-bottom:1px solid #e5e5e5;line-height:41px;height:41px;font-size:14px;">
        <span class="glyphicon glyphicon-home"></span> 首页 <span>&gt;</span> 用户管理 <span>&gt;</span> 用户列表
        <a class="btn btn-success btn-sm" href="javascript:location.replace(location.href);" style="float:right; margin-top:5px" title="刷新" >
            <span class="glyphicon glyphicon-refresh"></span>
        </a>
    </nav>


    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>用户信息管理</h1>
            </div>
        </div>
        <!-- 按钮 -->
        <div class="row">
            <div class="col-md-3 col-md-offset-4">
                <div class="input-group">
                    <input type="text" class="form-control" id="user_select_input" placeholder="请输入用户名" v-model="searchInfo.like">
                    <span class="input-group-btn">
               		<button class="btn btn-info btn-search" id="user_select_btn" @click="search">查找</button>
            	</span>
                </div>
            </div>
            <div class="col-md-5">
            </div>
        </div>
        <!-- 表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="users_table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>用户名</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th>电话</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="user in users">
                        <td>{{user.id}}</td>
                        <td>{{user.age}}</td>
                        <td>{{user.name}}</td>
                        <td>{{user.gender}}</td>
                        <td>{{user.mobile}}</td>
                        <td>
                            <button class="btn btn-primary btn-sm edit_user_btn" >
                                <span class="glyphicon glyphicon-pencil">编辑</span>
                            </button>
                            <button class="btn btn-danger btn-sm delete_user_btn">
                                <span class="glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="20">
                            <div class="table-responsive">
                                <div id="pageMenu"></div>
                            </div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<#include '../include/footer_js.ftl'/>
<script src="/assets/js/jquery.pagination-1.2.7.js"></script>
<script>
    var app = new Vue({
        el: '#userList',
        data: {
            users: [],//用户信息
            searchInfo: {//请求参数
                name:'',
                gender: 0,
                age:'',
                mobile:'',
                page: 1,
                pageSize: 10
            }
        },
        created: function () {
            this.searchInfo.page = 1;
            this.search();
        },
        watch:{
            "searchInfo.name":function () {
                this.search();
            }
        },
        methods: {
            search: function () {
                this.searchInfo.page = 1;
                $('#pageMenu').page('destroy');//销毁分页
                this.query();
            },
            query: function () {
                var url = "/api/user/list";
                this.$http.post(url, this.searchInfo).then(function (response) {
                    this.users = response.data.data.list;
                    console.log(this.users)
                    var temp = this;
                    $("#pageMenu").page({//加载分页
                        total: response.data.data.total,
                        pageSize: response.data.data.pageSize,
                        firstBtnText: '首页',
                        lastBtnText: '尾页',
                        prevBtnText: '上一页',
                        nextBtnText: '下一页',
                        showInfo: true,
                        showJump: true,
                        jumpBtnText: '跳转',
                        infoFormat: '{start} ~ {end}条，共{total}条'
                    }, response.data.data.page).on("pageClicked", function (event, pageIndex) {
                        temp.searchInfo.page = pageIndex + 1;
                    }).on('jumpClicked', function (event, pageIndex) {
                        temp.searchInfo.page = pageIndex + 1;
                    });
                }, function (error) {
                    swal(error.body.msg);
                });
            }
        }
    });
</script>
</body>
</html>