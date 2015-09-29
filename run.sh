#!/bin/bash
STATUS_FILE="/.rancid-enabled"
for i in "$@"; do
    case $i in
        -e|--enable)
            if [ -f ${STATUS_FILE} ]; then
                echo "RANCID is already enabled"
                exit 1
            else
                touch ${STATUS_FILE}
                if [ $? -eq 0 ]; then 
                    echo "RANCID enabled"
                    exit 0
                else
                    echo "RANCID enabling failed"
                    exit 1
                fi
            fi
            ;;
        -d|--disable)
            if [ -f ${STATUS_FILE} ]; then
                rm ${STATUS_FILE}
                echo "RANCID disabled"
                exit 0
            else
                echo "RANCID is already disabled"
                exit 1
            fi
            ;;
        -h|--help)
            echo "RANCID Docker starter"
            echo "$0 [--enable|--disable|--help]"
            echo -e "\t-e|--enable\tEnable RANCID"
            echo -e "\t-d|--disable\tDisable RANCID"
            echo -e "\t-h|--help\tThis help menu"
            exit 0
            ;;
        *)
            ;;
    esac
done

if [ -f ${STATUS_FILE} ]; then
    /usr/bin/sudo -u rancid -i rancid-run
else
    echo "RANCID not enabled ($1 -h for help)"
    exit 1
fi
