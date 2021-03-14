
1. To run all mcs, fcs, 3dx playbooks

   # ansible-playbook -i TEST site.yml -s -K
     [Enter Sudo Pass]


2. To run 3dx only

   # ansible-playbook -i TEST 3dx.yml -s -K
   
3. To Deploy only 3dx Files at target server 
   
   # ansible-playbook -i TEST 3dx.yml -s -K --tags deploy-script
   
     Tasks inlcuded :

            1. copy 15x_functions.j2
            2. copy PICMain_3dindex_server.sh.j2
            3. copy 3DXAdminHttpServer-launch.sh.j2
            4. copy BBDEnvEditor-launch.sh.j2 in scripts
            5. copy BBDIndexAdmin-lauch.sh.j2 in scripts
            6. copy indexation-launch.sh.j2 in scripts
            7. copy killscript.sh in scripts
            8. copy checkrun.sh in scripts
  
4. To run only 3dx service scripts at target server
 
   # ansible-playbook -i TEST 3dx.yml -s -K --tags run-script

     Tasks Included :
     
           1. Execute the killscript.sh script
           2. Execute the PICMain_3dindex_server.sh script
           3. Execute the 3DXAdminHttpServer-launch.sh script
           4. Execute the BBDEnvEditor-launch.sh script
           5. Execute the BBDIndexAdmin-lauch.sh script
           6. Execute the indexation-launch.sh script
           7. Execute the checkrun.sh script