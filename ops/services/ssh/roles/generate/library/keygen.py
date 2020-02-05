from Crypto.PublicKey import RSA
from os import getcwd, chmod
from ansible.module_utils.basic import AnsibleModule


class SshKey:

    def __init__(self, name: str, extension: str = "pem", bit_length: int = 2048):
        self.name: str = name
        self.extension: str = extension
        self.bit_length: int = bit_length
        self.key = RSA.generate(self.bit_length)

    def set_extension(self, ext: str = "pem"):
        self.extension = ext

    def set_filename(self, filename: str):
        self.name = filename

    @staticmethod
    def __write_key_file(key_data: bytes, file_path: str):
        if file_path == "" or key_data == b"":
            raise Exception("Null in data or filename")
        try:
            with open(file_path, "wb") as file:
                file.write(key_data)
        except PermissionError:
            raise Exception("Unable to open file %s" % file_path)

    def write_private(self):
        self.__write_key_file(
            file_path=".".join([self.name, self.extension]),
            key_data=self.key.exportKey(self.extension.upper())
        )

    def write_public(self):
        self.__write_key_file(
            file_path=".".join([self.name, self.extension, "pub"]),
            key_data=self.key.publickey().exportKey("OpenSSH")
        )


def run_module():
    module_args = dict(
        key_file=dict(type='str', required=True),
        extension=dict(type='str', required=False),
        path=dict(type='str', required=False),
        bit_length=dict(type='int', required=False),
        chmod=dict(type='int', required=False)
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

    key_file = module.params['key_file']
    extension = module.params['extension']
    path = module.params['path']
    bit_length = module.params['bit_length']
    mod = module.params['chmod']

    if path == "" or path is None:
        path = "/".join([getcwd(), "keys", key_file])

    key = SshKey(name=path, extension=extension, bit_length=bit_length)
    key.write_private()
    key.write_public()

    if mod != 0 or mod is not None:
        try:
            chmod("{0}.{1}".format(path, extension), 500)
        except PermissionError:
            module.fail_json(msg="Permissions denied on %s" % path, **result)
            module.exit_json(**result)

    result['message'] = 'Key saved as %s' % path
    result['changed'] = True
    module.log(result['message'])
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
