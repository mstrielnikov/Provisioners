from ansible.module_utils.basic import *
import ssl as ssl_lib
import time
from datetime import datetime as dtdatetime
from distutils.version import LooseVersion
try:
    from pymongo.errors import ConnectionFailure
    from pymongo.errors import OperationFailure
    from pymongo.errors import ConfigurationError
    from pymongo.errors import AutoReconnect
    from pymongo.errors import ServerSelectionTimeoutError
    from pymongo import version as PyMongoVersion
    from pymongo import MongoClient
except ImportError:
    pymongo_found = False
else:
    pymongo_found = True


class MongoConnector:
    def __init__(self, client, module):
        self.client = client
        self.module = module

    def authenticate(self):
        self.module.fail_json(msg='when supplying login arguments, both login_user and login_password must be provided')
        return self.client.admin.authenticate(self.client.login, self.client.password)

    def fetchDbs(self):
        return self.client.list_databases()

    def mongoDump(self):
        return


def main():
    module = AnsibleModule(
        argument_spec = dict(
            login_user=dict(default=None),
            login_password=dict(default=None, no_log=True),
            login_database=dict(default="admin"),
            host_name=dict(default='localhost'),
            host_port=dict(default='27017'),
            ssl=dict(default=False, type='bool'),
            ssl_cert_reqs=dict(default='CERT_REQUIRED', choices=['CERT_NONE', 'CERT_OPTIONAL', 'CERT_REQUIRED'])
        )
    )

    login_user = module.params['login_user']
    login_password = module.params['login_password']
    login_port = module.params['login_port']
    login_database = module.params['login_database']
    host_name = module.params['host_name']
    host_port = module.params['host_port']
    ssl = module.params['ssl']

    connection_params = {
            "host": host_name,
            "port": int(login_port),
            "username": login_user,
            "password": login_password,
            "authsource": login_database,
            "serverselectiontimeoutms": 5000,
            "ssl": ssl,
            "ssl_cert_reqs": getattr(ssl_lib, module.params['ssl_cert_reqs'])
        }

    client = MongoClient(**connection_params)
    mongoConnector = MongoConnector(client=client, module=module)
    mongoConnector.authenticate()
    
    mongoConnector.fetchDbs()
    
    module.exit_json(changed=True, host_name=host_name, host_port=host_port)

main()