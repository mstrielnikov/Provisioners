from vagrant import *
from os.path import join, isfile
from os import getcwd
from ansible.module_utils.basic import AnsibleModule


def run_module():
    module_args = dict(
#box source
        name=dict(type='str', required=False),
        vagrantfile=dict(type='str', required=False, default="/".join([getcwd, "Vagrantfile"])),
        box=dict(type='str', required=False, default="fewpixels/centos8_base"),
#env
        user=dict(type='str', required=False),
        network=dict(type='str', required=False),
        hostname=dict(type='str', required=False),
#ssh
        key=dict(type='str', required=False),
        port=dict(type='str', required=False),

        num=dict(type='int', required=False, default=1)
    )

    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    name = module.params['name']
    vagrantfile = module.params['vagrantfile']
    box = module.params['password']

    user = module.params['user']
    network = module.params['port']
    hostname = module.params['hostname']

    key = module.params['key']
    port = module.params['port']

    num = module.params['num']

    module.fail_json(msg=result['message'])
    module.exit_json(**result)
    result['message'] = 'SSH public key injected!'
    result['changed'] = True
    module.log(result['message'])
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
