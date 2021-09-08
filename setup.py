# Python package setup script        -*- coding: utf-8 -*-

name = "demjson3"
version = "3.0.3"

from setuptools import setup

from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

with open(path.join(here, "README.md"), encoding="utf-8") as f:
    long_description = f.read()

setup(
    name=name,
    version=version,
    py_modules=[name],
    scripts=["jsonlint"],
    author="Deron Meranda",
    author_email="deron.meranda@gmail.com",
    description="encoder, decoder, and lint/validator for JSON (JavaScript Object Notation) compliant with RFC 7159",
    long_description=long_description,
    long_description_content_type="text/markdown",
    license="GNU LGPL 3.0",
    keywords=["JSON", "jsonlint", "JavaScript", "UTF-32"],
    platforms=[],
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: GNU Library or Lesser General Public License (LGPL)",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Topic :: Internet :: WWW/HTTP :: Dynamic Content",
    ],
)
