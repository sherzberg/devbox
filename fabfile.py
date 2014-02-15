import os
from fabric.api import task, env, sudo, settings, hide, cd, execute
from loom.tasks import *
from loom import puppet

HOST = os.environ['CLOUD_HOST']
env.puppet_module_dir = 'puppet/modules/'
env.roledefs = {
    'dev': ['root@%s' % HOST],
}


@task
def provision():
    execute(puppet.update)
    execute(puppet.apply)
