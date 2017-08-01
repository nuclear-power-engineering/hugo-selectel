#!/bin/bash

hugo -s /data
supload.sh -u USRNAME -k USERKEY -r storage_dir /data/public