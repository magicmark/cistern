#!/usr/bin/env python
"""This script will bootstrap a virtualenv from only a python interpreter."""
from __future__ import absolute_import
from __future__ import unicode_literals

import contextlib
import hashlib
import io
import os.path
import shutil
import subprocess
import sys
import tarfile


if str is bytes:
    from urllib import urlopen
else:
    from urllib.request import urlopen


TGZ = 'https://pypi.python.org/packages/d4/0c/9840c08189e030873387a73b90ada981885010dd9aea134d6de30cd24cb8/virtualenv-15.1.0.tar.gz'  # noqa
EXPECTED_MD5 = '44e19f4134906fe2d75124427dc9b716'
PKG_PATH = '.virtualenv-pkg'


def clean():
    if os.path.exists(PKG_PATH):
        shutil.rmtree(PKG_PATH)


@contextlib.contextmanager
def clean_path():
    try:
        yield
    finally:
        clean()


def main(argv=None):
    clean()

    print('Downloading ' + TGZ)
    tar_contents = io.BytesIO(urlopen(TGZ).read())
    actual_md5 = hashlib.md5(tar_contents.getvalue()).hexdigest()
    if actual_md5 != EXPECTED_MD5:
        raise AssertionError(actual_md5, EXPECTED_MD5)
    with contextlib.closing(tarfile.open(fileobj=tar_contents)) as tarfile_obj:
        # Chop off the first path segment to avoid having the version in
        # the path
        for member in tarfile_obj.getmembers():
            _, _, member.name = member.name.partition('/')
            if member.name:
                tarfile_obj.extract(member, PKG_PATH)
    print('Done.')

    with clean_path():
        return subprocess.call(
            (sys.executable, os.path.join(PKG_PATH, 'virtualenv.py')) +
            tuple(sys.argv[1:])
        )


if __name__ == '__main__':
    exit(main())
