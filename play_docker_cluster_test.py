from os import getcwd, remove
from subprocess import Popen, PIPE


path = getcwd()
inv_file = "{0}/ops/cluster/container/hosts.yml".format(path)
test_playbook = "{0}/ops/cluster/container/play.yml".format(path)
init_command = ["ansible-playbook -i {0} {1}".format(inv_file, test_playbook)]

Popen(init_command, stderr=PIPE).wait().communicate()
remove(file)
