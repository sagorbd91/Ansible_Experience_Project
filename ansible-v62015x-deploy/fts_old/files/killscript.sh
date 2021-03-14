#/bin/bash

kill $(ps aux | grep 'PICMain' | awk '{print $2}')
kill $(ps aux | grep 'CATPLMIndexServer' | awk '{print $2}')
kill $(ps aux | grep 'CATBBDHTTPServ' | awk '{print $2}')