<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="header.jsp" %>

<script>
    app.controller("angController", function ($scope, $http, $filter) {
        $scope.users = [];
        $scope.userTypes = [];
        $scope.userStatuses = [];
        $scope.languages = [];

        $scope.loadMainData = function () {
            $('#loadingModal').modal('hide');

            function getUsers(res) {
                $scope.users = res.data;
                $('#loadingModal').modal('hide');
            }

            ajaxCall($http, "users/get-users", null, getUsers);
        }

        $scope.loadMainData();

        $scope.remove = function (id) {
            if (confirm("დარწმუნებული ხართ რომ გსურთ წაშლა?")) {
                if (id != undefined) {
                    function resFnc(res) {
                        if (res.errorCode == 0) {
                            successMsg('ოპერაცია დასრულდა წარმატებით');
                            $scope.loadMainData();
                        }
                    }

                    ajaxCall($http, "users/delete-user?id=" + id, null, resFnc);
                }
            }
        };

        $scope.edit = function (id) {
            if (id != undefined) {
                var selected = $filter('filter')($scope.users, {userId: id}, true);
                $scope.request = selected[0];
                $scope.request.languages = [];
                $scope.loadDetailsList($scope.request.userId);
            }
        };

        $scope.loadDetailsList = function (id) {
            function getLanguages(res) {
                angular.forEach(res.data, function (v) {
                    $scope.request.languages.push(v.language.id);
                });
            }

            ajaxCall($http, "users/get-user-languages?id=" + id, null, getLanguages);
        }

        $scope.init = function () {
            $scope.request = null;
            $scope.request = {statusId: 1, typeId: 1};
        };

        $scope.save = function () {
            function resFunc(res) {
                if (res.errorCode == 0) {
                    successMsg('Operation Successfull');
                    $scope.loadMainData();
                    closeModal('editModal');
                } else {
                    errorMsg('Operation Failed');
                }
            }

            if ($scope.request.insertDate != undefined && $scope.request.insertDate.includes('/')) {
                $scope.request.insertDate = $scope.request.insertDate.split(/\//).reverse().join('-')
            }

            $scope.req = {};

            if ($scope.request.languages.length > 0) {
                $scope.tmp = [];
                angular.forEach($scope.request.languages, function (v) {
                    if (v !== false) {
                        $scope.tmp.push(v);
                    }
                });
                $scope.req.languages = $scope.tmp;
            }

            $scope.req.userId = $scope.request.userId;
            $scope.req.userDesc = $scope.request.userDesc;
            $scope.req.userName = $scope.request.userName;
            $scope.req.userPassword = $scope.request.userPassword;
            $scope.req.typeId = $scope.request.typeId;
            $scope.req.deleted = $scope.request.deleted;
            $scope.req.email = $scope.request.email;
            $scope.req.emailPassword = $scope.request.emailPassword;

            console.log($scope.req);
            ajaxCall($http, "users/save-user", angular.toJson($scope.req), resFunc);
        };

        function getUserTypes(res) {
            $scope.userTypes = res.data;
        }

        ajaxCall($http, "users/get-user-types", null, getUserTypes);

        function getLanguages(res) {
            $scope.languages = res.data;
        }

        ajaxCall($http, "misc/get-languages", null, getLanguages);

    });
</script>


<div class="modal fade bs-example-modal-lg" id="editModal" role="dialog" aria-labelledby="editModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editModalLabel">Personal Information</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form class="form-horizontal" name="myForm">
                        <div class="form-group col-sm-10 ">
                            <label class="control-label col-sm-3">UserName</label>
                            <div class="col-sm-9">
                                <input type="text" ng-model="request.userName"
                                       class="form-control input-sm">
                            </div>
                        </div>
                        <div class="form-group col-sm-10 ">
                            <label class="control-label col-sm-3">Password</label>
                            <div class="col-sm-9">
                                <input type="password" name="password" ng-model="request.userPassword"
                                       class="form-control input-sm">
                            </div>
                        </div>
                        <div class="form-group col-sm-10 ">
                            <label class="control-label col-sm-3">First - Last Name </label>
                            <div class="col-sm-9">
                                <input type="text" ng-model="request.userDesc" class="form-control input-sm">
                            </div>
                        </div>
                        <div class="form-group col-sm-10">
                            <label class="control-label col-sm-3">Email</label>
                            <div class="col-xs-9">
                                <input type="text" ng-model="request.email" class="form-control input-sm">
                            </div>
                        </div>
                        <div class="form-group col-sm-10">
                            <label class="control-label col-sm-3">Email Password</label>
                            <div class="col-xs-9">
                                <input type="text" ng-model="request.emailPassword" class="form-control input-sm">
                            </div>
                        </div>
                        <div class="form-group col-sm-10 ">
                            <label class="control-label col-sm-3">Languages</label>
                            <div class="col-sm-9">
                                <label ng-repeat="t in languages" class="col-sm-6">
                                    <input type="checkbox" id="languageChek{{t.id}}"
                                           checklist-model="request.languages" checklist-value="t.id">&nbsp; {{t.name}}
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-sm-10">
                            <label class="control-label col-sm-3">Level</label>
                            <div class="col-xs-9 btn-group">
                                <select class="form-control" ng-model="request.typeId">
                                    <option ng-repeat="s in userTypes"
                                            ng-selected="s.userTypeId === request.type.userTypeId"
                                            ng-value="s.userTypeId">{{s.userTypeName}}
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-sm-10">
                            <label class="control-label col-sm-3">Status</label>
                            <div class="col-xs-9 btn-group">
                                <div class="radio col-xs-6">
                                    <label><input type="radio" ng-model="request.deleted" value="0"
                                                  class="input-sm">Active</label>&nbsp;
                                    <label><input type="radio" ng-model="request.deleted" value="1"
                                                  class="input-sm">Passive</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-10"></div>
                        <div class="form-group col-sm-10"></div>
                        <div class="form-group col-sm-12 text-center">
                            <a class="btn btn-app" ng-click="save()">
                                <i class="fa fa-save"></i> Save
                            </a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row">
    <div class="col-xs-12">
        <div class="box">
            <div class="box-header">
                <div class="col-md-2">
                    <button type="button" class="btn btn-block btn-primary btn-md" ng-click="init()" data-toggle="modal"
                            data-target="#editModal">
                        <i class="fa fa-plus" aria-hidden="true"></i> &nbsp;
                        Add User
                    </button>
                </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>First-Last Name</th>
                        <th>User Name</th>
                        <th>Type</th>
                        <th>Language</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th class="col-md-1 text-center">Create Date</th>
                        <th class="col-md-2 text-center">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="r in users">
                        <td>{{r.userId}}</td>
                        <td>{{r.userDesc}}</td>
                        <td>{{r.userName}}</td>
                        <td>{{r.type.userTypeName}}</td>
                        <td>{{r.language.name}}</td>
                        <td>{{r.email}}</td>
                        <td>{{r.deleted == 0 ? 'Active': 'Passive'}}</td>
                        <td class="text-center">
                            <small>{{r.createDate}}</small>
                        </td>
                        <td class="text-center">
                            <a ng-click="edit(r.userId)" data-toggle="modal" data-target="#editModal"
                               class="btn btn-xs">
                                <i class="fa fa-pencil"></i>&nbsp;Edit
                            </a>&nbsp;|&nbsp;
                            <a ng-click="remove(r.userId)" class="btn btn-xs">
                                <i class="fa fa-trash-o"></i>&nbsp;Remove
                            </a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>