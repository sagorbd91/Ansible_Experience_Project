#!/bin/bash

#all_port=$( awk {'print $1'} 3dindex | sort )
numberofport=$(ps -ef | grep CATSTART | awk '{print $14}' | sed -e '/[1-9]/!d' -e '/a/d' -e 's/[#@$]//g' | wc -l)
picmain=$( ps cax | grep PICMain | awk '{print $5}' )
startpooler=$( grep KoalaPoolSize /plm/v62015x/search/3dx/code/linux_a64/startup/KOALAConfig/KOALA.properties | cut -d= -f2 )

if [ $numberofport -eq 0 ] || [ $picmain != PICMain ]
        then
                echo "PICMain down"

else

        if [ $numberofport -eq $startpooler ] && [ $picmain == PICMain ]
                then
                echo "PICMain+Port OK"

        else

             if [ $numberofport -lt $startpooler ]
                then
                echo avg
                else
                echo problem
            fi
        fi
fi

# Old Code....

#PIC=`ps -ef | grep PIC`
#IndexServer=`ps -ef | grep IndexServer`
#BBDAdminPlayer=`ps -ef | grep BBDAdminPlayer`
#CATBBDHTTPServ=`ps -ef | grep CATBBDHTTPServ`

#echo $PIC
#echo $IndexServer
#echo $BBDAdminPlayer
#echo $CATBBDHTTPServ
