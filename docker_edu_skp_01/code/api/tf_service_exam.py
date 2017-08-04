import tensorflow as tf
from rest_framework.response import Response
from rest_framework.views import APIView
import json
from .tf_service_logic import TfExamBackendService as tebs

class TfExamService(APIView):

    def post(self, request, operator, values):
        return_data = {"status":"200","result":"post"}
        value_list = [int(_l) for _l in  values.split(',')]
        tf_result = tebs.tf_logic_train_reduce_sum(self, value_list[0])
        return_data = {}
        return_data["status"] = 200
        return_data["result"] = str(tf_result)
        return_data["operator"] = str(operator)
        return Response(json.dumps(return_data))

    def get(self, request,operator, values):
        print("get")
        value_list = [int(_l) for _l in  values.split(',')]
        tf_result = tebs.tf_logic(self, value_list[0], value_list[1])
        return_data = {}
        return_data["status"] = 200
        return_data["result"] = str(tf_result)
        return_data["operator"] = str(operator)
        return_data["values"] = str(values)
        return_data["value_list"]= value_list
        return Response(json.dumps(return_data))

    def put(self, request,operator, values):
        print("put")
        return_data = {"status":"200","result":"put"}
        return Response(json.dumps(return_data))


    def delete(self, request,operator, values):
        print("delete")
        return_data = {"status":"200","result":"delete"}
        return Response(json.dumps(return_data))

