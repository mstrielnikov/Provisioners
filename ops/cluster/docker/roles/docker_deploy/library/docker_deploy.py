from ansible.module_utils.basic import AnsibleModule
import docker
import docker.errors


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

    try:
        docker_container = client.containers.run(
            str(docker_image.id),
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
