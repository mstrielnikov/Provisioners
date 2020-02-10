from ansible.module_utils.basic import AnsibleModule
import docker
import docker.errors


ANSIBLE_METADATA = {
    'metadata_version': '1.0',
    'status': ['stable'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
---
module: share

short_description: Inject SSH public key to remote systems

version_added: "2.4"

description:
    - "Inject SSH public key for password less remote system login."

options:
    host:
        description:
            - Remote system hostname or IP address
        required: true
    username:
        description:
            - Username to login to remote system
        required: true
    password:
        description:
            - Password to login to remote system
        required: true
    ssh_public_key:
        description:
            - SSH public key (include absolute path)
        required: true
    ssh_port:
        description:
            - SSH port
        required: false
author:
    - Ryan Williams
'''

EXAMPLES = '''
# Inject SSH public key into remote system
- name: Inject SSH public key
  ssh_copy_id:
    hostname: host123
    username: username
    password: password
    ssh_public_key: /home/user/.ssh/id_rsa.pub
    ssh_port: 22
'''

RETURN = '''
changed:
    description: Whether the module performed an action or not
    type: bool
message:
    description: The output message that the sample module generates
    type: str
original_message:
    description: The original name param that was passed in
    type: str
'''


def run_module():
    module_args = dict(
        dockerfile=dict(type='str', required=True),
        network=dict(type='str', required=True),
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

    dockerfile_name = module.params['dockerfile']
    network = module.params['network']

    client = docker.from_env()
    docker_image = None

    try:
        docker_image = client.build(
            path=dockerfile_name,
            quiet=True,
            rm=True)
    except docker.errors.APIError:
        module.fail_json(msg="Error building image from dockerfile %s" % dockerfile_name, **result)
        module.exit_json(**result)
    else:
        result['message'] = 'Image %s was built' % docker_image.id
        module.log(result['message'])

    docker_container = None

    print(docker_image.name)

    try:
        docker_container = client.containers.run(
            str(docker_image.name),
            detach=True,
            restart_policy="on-fail",
            mem_swapiness=0,
            network=network,
            network_mode="bridge",
        )
    except docker.errors.APIError:
        module.fail_json(msg="Error running container %s" % docker_container.name, **result)
        module.exit_json(**result)
    else:
        result['message'] = 'Container deployed'
        module.log(result['message'])

    module.log(result['message'])
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
