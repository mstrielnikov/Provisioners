from Crypto.PublicKey import RSA
from os import chmod

ssh_cred_path="resources/ssh/ansible"


class SshKey:

    def __init__(self, name: str = ssh_cred_path, extension: str = "pem", bit_length: int = 2048):
        self.name: str = name
        self.extension: str = extension
        self.bit_length: int = bit_length
        self.key = RSA.generate(self.bit_length)

    def set_extension(self, ext: str = "pem"):
        self.extension = ext

    def set_filename(self, filename: str):
        self.name = filename

    @staticmethod
    def __write_key_file(key_data: bytes, file_path):
        try:
            with open(file_path, "wb") as file:
                file.write(key_data)
        except:
            raise("Unable to open file %s" % file_path)
        try:
            chmod(file_path, 500)
        except:
            raise("Permissions denied on %s" % file_path)

    def write_private(self):
        self.__write_key_file(
            file_path = ".".join([self.name, self.extension]),
            key_data=self.key.exportKey(self.extension.upper())
            )

    def write_public(self):
        self.__write_key_file(
            file_path = ".".join([self.name, "pub", self.extension]),
            key_data=self.key.publickey().exportKey("OpenSSH")
            )


if __name__ == "__main__":
    ssh = SshKey()
    ssh.write_private()
    ssh.write_public()
