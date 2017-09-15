#!/bin/bash

logger "Shutting down node due to lack of work!"

/sbin/shutdown -h now
exit 0

