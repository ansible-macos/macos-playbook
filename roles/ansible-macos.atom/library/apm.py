#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2017, Luis Hdez <luis.munoz.hdez@gmail.com> [npm -> apm]

ANSIBLE_METADATA = {'status': ['preview'],
                    'supported_by': 'community',
                    'version': '1.0'}

DOCUMENTATION = '''
---
module: apm
short_description: Manage atom packages with apm
description:
  - Manage Atom packages with Node Package Manager (apm)
version_added: 1.2
author: "Luis hdez (@chrishoffman)"
options:
  name:
    description:
      - The name of a node.js library to install
    required: false
  version:
    description:
      - The version to be installed
    required: false
  ignore_scripts:
    description:
      - Use the --ignore-scripts flag when installing.
    required: false
    choices: [ "yes", "no" ]
    default: no
    version_added: "1.8"
  state:
    description:
      - The state of the node.js library
    required: false
    default: present
    choices: [ "present", "absent" ]
'''

EXAMPLES = '''
description: Install "coffee-script" Atom package.
- apm:
    name: coffee-script
description: Install "coffee-script" Atom package on version 1.6.1.
- apm:
    name: coffee-script
    version: '1.6.1'
description: Remove the package "coffee-script".
- apm:
    name: coffee-script
    state: absent
'''

import os

try:
    import json
except ImportError:
    try:
        import simplejson as json
    except ImportError:
        # Let snippet from module_utils/basic.py return a proper error in this case
        pass


class Apm(object):
    def __init__(self, module, **kwargs):
        self.module = module
        self.glbl = kwargs['glbl']
        self.name = kwargs['name']
        self.version = kwargs['version']
        self.path = kwargs['path']
        self.registry = kwargs['registry']
        self.production = kwargs['production']
        self.ignore_scripts = kwargs['ignore_scripts']

        if kwargs['executable']:
            self.executable = kwargs['executable'].split(' ')
        else:
            self.executable = [module.get_bin_path('apm', True)]

        if kwargs['version']:
            self.name_version = self.name + '@' + str(self.version)
        else:
            self.name_version = self.name

    def _exec(self, args, run_in_check_mode=False, check_rc=True):
        if not self.module.check_mode or (self.module.check_mode and run_in_check_mode):
            cmd = self.executable + args

            if self.glbl:
                cmd.append('--global')
            if self.production:
                cmd.append('--production')
            if self.ignore_scripts:
                cmd.append('--ignore-scripts')
            if self.name:
                cmd.append(self.name_version)
            if self.registry:
                cmd.append('--registry')
                cmd.append(self.registry)

            #If path is specified, cd into that path and run the command.
            cwd = None
            if self.path:
                if not os.path.exists(self.path):
                    os.makedirs(self.path)
                if not os.path.isdir(self.path):
                    self.module.fail_json(msg="path %s is not a directory" % self.path)
                cwd = self.path

            rc, out, err = self.module.run_command(cmd, check_rc=check_rc, cwd=cwd)
            return out
        return ''

    def list(self):
        cmd = ['list', '--json']

        installed = list()
        missing = list()
        data = json.loads(self._exec(cmd, True, False))
        if 'dependencies' in data:
            for dep in data['dependencies']:
                if 'missing' in data['dependencies'][dep] and data['dependencies'][dep]['missing']:
                    missing.append(dep)
                elif 'invalid' in data['dependencies'][dep] and data['dependencies'][dep]['invalid']:
                    missing.append(dep)
                else:
                    installed.append(dep)
            if self.name and self.name not in installed:
                missing.append(self.name)
        #Named dependency not installed
        else:
            missing.append(self.name)

        return installed, missing

    def install(self):
        return self._exec(['install'])

    def update(self):
        return self._exec(['update'])

    def uninstall(self):
        return self._exec(['uninstall'])


def main():
    arg_spec = dict(
        name=dict(default=None),
        path=dict(default=None, type='path'),
        version=dict(default=None),
        production=dict(default='no', type='bool'),
        executable=dict(default=None, type='path'),
        registry=dict(default=None),
        state=dict(default='present', choices=['present', 'absent']),
        ignore_scripts=dict(default=False, type='bool'),
    )
    arg_spec['global'] = dict(default='no', type='bool')
    module = AnsibleModule(
        argument_spec=arg_spec,
        supports_check_mode=True
    )

    name = module.params['name']
    path = module.params['path']
    version = module.params['version']
    glbl = module.params['global']
    production = module.params['production']
    executable = module.params['executable']
    registry = module.params['registry']
    state = module.params['state']
    ignore_scripts = module.params['ignore_scripts']

    if not path and not glbl:
        module.fail_json(msg='path must be specified when not using global')
    if state == 'absent' and not name:
        module.fail_json(msg='uninstalling a package is only available for named packages')

    apm = Apm(module, name=name, path=path, version=version, glbl=glbl, production=production, \
              executable=executable, registry=registry, ignore_scripts=ignore_scripts)

    changed = False
    if state == 'present':
        installed, missing = apm.list()
        if len(missing):
            changed = True
            apm.install()
    else: #absent
        installed, missing = apm.list()
        if name in installed:
            changed = True
            apm.uninstall()

    module.exit_json(changed=changed)

# import module snippets
from ansible.module_utils.basic import *

if __name__ == '__main__':
    main()
