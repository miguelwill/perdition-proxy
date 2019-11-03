#!/bin/bash

cd /etc/perdition

makegdbm popmap.gdbm.db < popmap

/etc/init.d/perdition restart

