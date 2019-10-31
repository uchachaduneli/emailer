<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>ავტორიზაცია</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/AdminLTE.css">
    <link rel="stylesheet" href="css/global.css">
    <link rel="shortcut icon" type="image/png" href="imgs/logo.jpg"/>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/global_util.js"></script>
    <script src="js/growlMessages.js"></script>
    <script src="js/jquery.bootstrap-growl.min.js"></script>
    <script src="js/angular.js"></script>

    <script type="text/javascript">
        $(document).keypress(function (e) {
            if (e.which == 13) {
                document.getElementById("auth").click();
            }
        });

        var app = angular.module("app", []);
        app.controller("loginCtrl", function ($scope, $http, $location) {
            var absUrl = $location.absUrl();
            $scope.uri = "";
            if (absUrl.split("?")[1]) {
                $scope.uri = absUrl.split("?")[1].split("=")[1];
            }

            $scope.login = function () {

                $.ajax({
                    type: "POST",
                    url: "login",
                    data: "username=" + $scope.user.username + "&password=" + $scope.user.password,
                    success: function (response) {
                        location.reload();

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        if (errorThrown == 'Bad Request') {
                            errorMsg("Can't authorise, Please Check the credentials");
                        }
                        console.log(textStatus, errorThrown);
                    }
                });
            };
        });

    </script>

</head>
<body ng-app="app" class="hold-transition login-page">
<div class="login-box" data-role="none" ng-controller="loginCtrl">
    <div class="login-logo">
        <a href=""><img class="col-xs-12" src="imgs/logo.jpg"></a>
    </div>
    <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>
        <form>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" id="username" name="username" ng-model="user.username"
                       placeholder="Username">
                <span class="fa fa-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" id="password" name="password" ng-model="user.password"
                       placeholder="Password">
                <span class="fa fa-key form-control-feedback"></span>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-12">
                    <button type="submit" ng-click="login()" class="btn btn-primary btn-block btn-flat">L o g i n
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
