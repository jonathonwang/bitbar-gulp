#!/bin/bash
#To Make my life easier getting the process path
function pwdx {
  lsof -a -p $1 -d cwd -n | tail -1 | awk '{print $NF}'
}


BLUE='blue';
GREEN='green';
RED='red';

RUN_ICON='⊚';
RUNNING_ICON='';
CLOSE_ICON='⊗';
GULP_ICON='🍹';


BUILDS_PATH='~/Documents/Builds';
GULP_PID=$(pgrep gulp);


# Check if there is a running GULP process
if [ "$GULP_PID" != "" ]
then
  GULP_PROCESS=$( pwdx $GULP_PID );
  RUNNING_PROJECT=${GULP_PROCESS##*/};
  RUNNING_NAME=$(echo $RUNNING_PROJECT | awk '{print toupper($0)}');
  pgrep gulp > /dev/null && echo "$GULP_ICON Gulp - $RUNNING_NAME | color=$GREEN" || echo "$GULP_ICON Gulp| color=black";
else
  pgrep gulp > /dev/null && echo "$GULP_ICON Gulp | color=$GREEN" || echo "$GULP_ICON Gulp| color=black";
fi



echo ---;
echo 'Projects ⇂';

## declare an array variable for my projects
declare -a projects=("opg" "opg-ui" "aa2")

projectsLENGTH=${#projects[@]}

# Check if GULP is a running process
# if pgrep gulp > /dev/null
# then
#   echo "$CLOSE_ICON Stop Gulp | color=$RED bash=kill param1=-INT param2=$GULP_PID refresh=false terminal=true";
# fi


## now loop through the above array
for i in "${projects[@]}"
do
   UPPER_NAME=$(echo $i | awk '{print toupper($0)}');
   #Check if the running GULP process in the project
   if [ "$RUNNING_PROJECT" == "$i" ]
   then
     echo "$CLOSE_ICON Stop $UPPER_NAME | color=$RED bash=kill param1=-INT param2=$GULP_PID refresh=false terminal=true";
   else
     echo "$RUN_ICON $UPPER_NAME | color=$BLUE bash=cd param1=$BUILDS_PATH/$i/ param2=&&gulp& terminal=true refresh=true ";
     echo "$RUN_ICON Watch $UPPER_NAME | color=$BLUE bash=cd param1=$BUILDS_PATH/$i/ param2=&&gulp param3=watch& terminal=true refresh=true alternate=true";
   fi
done
# You can access them using echo "${arr[0]}", "${arr[1]}" also


# OPG_DISPLAY="$RUN_ICON OPG | color=$BLUE bash=cd param1=$OPG_PATH param2=&&gulp terminal=true refresh=true ";
# echo $OPG_DISPLAY;
