import json
from rest_framework.response import Response
from rest_framework.views import APIView
from master.automl.automl import AutoMlCommon
import coreapi

class RunManagerAutoConf(APIView):

    coreapi_fields = (
        coreapi.Field(
            name='netconf_node',
            required=True,
            type='string',
        ),
        coreapi.Field(
            name='datasrc',
            required=True,
            type='string',
        ),
        coreapi.Field(
            name='evaldata',
            required=True,
            type='string',
        ),
        coreapi.Field(
            name='evalnode',
            required=True,
            type='string',
        ),
    )
    def post(self, request, nnid):
        """
        Manage hyperparameter for GA algorithm like eval, population, survive etc
        Structure : AutoML - NetID - NetVer(Auto Generated by GA) - NetBatch (auto generated on every batch) \n
        (1) Define AutoML Graph definition \n
        (2) Select Type of Data \n
        (3) Select Type of Anal algorithm \n
        (4) Select range of hyper parameters (<- for this step)\n
        (5) Run - AutoML \n
        (6) Check result of each generation with UI/UX \n
        (7) Select Best model you want use and activate it \n
        ---
        # Class Name : RunManagerAutoConf

        # Description:
            Set hyperparameters for genetic algorithm itself, if it is not set
            Genetic Algorithm will run with default parmas
        """
        try:
            return_data = AutoMlCommon().update_conf_obj(nnid, request.data)
            return Response(json.dumps(return_data))
        except Exception as e:
            return_data = {"status": "404", "result": str(e)}
            return Response(json.dumps(return_data))

    def get(self, request, nnid):
        """
        Manage hyperparameter for GA algorithm like eval, population, survive etc
        Structure : AutoML - NetID - NetVer(Auto Generated by GA) - NetBatch (auto generated on every batch) \n
        (1) Define AutoML Graph definition \n
        (2) Select Type of Data \n
        (3) Select Type of Anal algorithm \n
        (4) Select range of hyper parameters (<- for this step)\n
        (5) Run - AutoML \n
        (6) Check result of each generation with UI/UX \n
        (7) Select Best model you want use and activate it \n
        ---
        # Class Name : RunManagerAutoConf

        # Description:
            Get hyperparameters for genetic algorithm itself, if it is not set
            Genetic Algorithm will run with default parmas
        """
        try:
            return_data = AutoMlCommon().get_conf_obj(nnid)
            return Response(json.dumps(return_data))
        except Exception as e:
            return_data = {"status": "404", "result": str(e)}
            return Response(json.dumps(return_data))

    def put(self, request, nnid):
        """
        Manage hyperparameter for GA algorithm like eval, population, survive etc
        Structure : AutoML - NetID - NetVer(Auto Generated by GA) - NetBatch (auto generated on every batch) \n
        (1) Define AutoML Graph definition \n
        (2) Select Type of Data \n
        (3) Select Type of Anal algorithm \n
        (4) Select range of hyper parameters (<- for this step)\n
        (5) Run - AutoML \n
        (6) Check result of each generation with UI/UX \n
        (7) Select Best model you want use and activate it \n
        ---
        # Class Name : RunManagerAutoConf

        # Description:
            Modifiy hyperparameters for genetic algorithm itself, if it is not set
            Genetic Algorithm will run with default parmas
        """
        try:
            return_data = AutoMlCommon().update_conf_obj(nnid, request.data)
            return Response(json.dumps(return_data))
        except Exception as e:
            return_data = {"status": "404", "result": str(e)}
            return Response(json.dumps(return_data))

    def delete(self, request, nnid):
        """
        Manage hyperparameter for GA algorithm like eval, population, survive etc
        Structure : AutoML - NetID - NetVer(Auto Generated by GA) - NetBatch (auto generated on every batch) \n
        (1) Define AutoML Graph definition \n
        (2) Select Type of Data \n
        (3) Select Type of Anal algorithm \n
        (4) Select range of hyper parameters (<- for this step)\n
        (5) Run - AutoML \n
        (6) Check result of each generation with UI/UX \n
        (7) Select Best model you want use and activate it \n
        ---
        # Class Name : RunManagerAutoConf

        # Description:
            Delete hyperparameters for genetic algorithm itself, if it is not set
            Genetic Algorithm will run with default parmas
        """
        try:
            return_data = ""
            return Response(json.dumps(return_data))
        except Exception as e:
            return_data = {"status": "404", "result": str(e)}
            return Response(json.dumps(return_data))
