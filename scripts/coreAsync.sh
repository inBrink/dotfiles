#!/bin/bash

#Default variables
sourceDirName="source/"
nodeDirName="../"
async="false"
npminstall="false"
check="not_exist"

cloneLocal="false"
GulpLocalDirectory="I://Dropbox/CODE/templates/gulp/"
CoreLocalDirectory="I://Dropbox/CODE/core/"
NodeLocalDipendencies="I://Dropbox/CODE/node_modules"

NodeCloudLink="https://www.dropbox.com/s/udbzwqpbcb634e3/node_modules.zip?dl=1"

# Debugging variables
# disableGulpRun="true"
disableGulpRun="false"

#Arguments check
while :; do
  case $1 in
    -h|\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
      # show_help
      echo "help"
      return
      # exit
      ;;
    -fi|--file)       # Takes an option argument, ensuring it has been specified.
      if [ -n "$2" ]; then
        file=$2
        shift
      else
        printf '' >&2
        exit 1
      fi
      ;;
    --file=?*)
      file=${1#*=} # Delete everything up to "=" and assign the remainder.
      ;;
    --file=)         # Handle the case of an empty --file=
      printf 'ERROR: "--file" requires a non-empty option argument.\n' >&2
      exit 1
      ;;
    -l|--local)         # Clone from local repo 
      cloneLocal="true"
      # printf 'ERROR: "--file" requires a non-empty option argument.\n' >&2
      # exit 1
      # shift
      ;;
    -i|--install)
      npminstall="true"
      ;;
    -a|--async)
      async="true"
      # shift
      ;;
    -v1|--version1)         # time: ~2:24,4
      async="false"
      cloneLocal="false"
      npminstall="true"
      ;;
    -v2|--version2)         # time: ~2:14,0
      async="true"
      cloneLocal="true"
      npminstall="true"
      ;;
    -v3|--version3|--cloud) # time ~14,3 (different internet connection to dropbox)
      async="true"
      cloneLocal="false"
      npminstall="false"
      ;;
    -v4|--version4|-f|--fast)  # time ~6,8
      async="true"
      cloneLocal="true"
      npminstall="false"
      ;;
    --)                     # End of all options.
      shift
      break
      ;;
    -?*)
      printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
      ;;
    *)                      # Default case: If no more options then break out of the loop.
      break
  esac

  shift
done

create_project_dir()
{
  echo "Project name: "
  read -r project_name
}

initProjectFunc()
{
  if [ "$1" ]; then
    project_name=$1
  else
    create_project_dir
  fi
  while [ -d "$project_name" ]
  do
    echo "- this name already exist, try again"
    create_project_dir
  done
  mkdir "$project_name"
  mkdir "$project_name"/$sourceDirName
  echo "+ project directory created"
  cd "$project_name"
}

extract_git()
{
  rm ${1}/*.md && rm -rf ${1}/.git
  mv ${1}/* $2
  rm -rf $1
}

nodeModulesFunc()
{
  if [ -d "${nodeDirName}node_modules" ]; then
    check="exist"
  fi
}

gulpDependencies()
{
  if [ "$npminstall" = "true" ]; then
    npm install &> /dev/null
    mv node_modules $nodeDirName
  else
    if [ "$cloneLocal" = "true" ]; then
      cp -r "$NodeLocalDipendencies" $nodeDirName
    else
      { curl -L "$NodeCloudLink" > node.zip && unzip node.zip -d $nodeDirName; } &> /dev/null
        rm node.zip
    fi
  fi
}

gulpFunc()
{
  if [ "$cloneLocal" = "true" ]; then
    cp -r "$GulpLocalDirectory" ./ && extract_git ./gulp ./
  else
    { git clone git@gitlab.com:StudiaUtEdamVivo/gulp.git && extract_git ./gulp ./; } &> /dev/null
  fi
}

coreFunc()
{
  if [ "$cloneLocal" = "true" ]; then
    cp -r "$CoreLocalDirectory" ./
    extract_git ./core ./$sourceDirName
  else
    {
      git clone git@gitlab.com:StudiaUtEdamVivo/core.git
      extract_git ./core ./$sourceDirName
    } &> /dev/null
  fi
}

gems_install()
{
  gems=(compass susy breakpoint)
  for i in ${gems[*]}; do
    if gem list "$i" -i > /dev/null 2>&1; then
      echo gem "$i" already installed
    else
      gem install "$i" &
    fi
  done
}

runNpmGulp()
{
  if [ -d "$sourceDirName/sass/" ] && [ "$disableGulpRun" = "false" ]; then
    echo "run gulp (y/n)?"
    read -r -n 1 answer2
    if [ "$answer2" = "y" ]; then
      echo -e "\nok > gulp starting"
      explorer .
      npm run gulp
    else
      explorer .
    fi
  fi
  # echo "runNpmGulp end"
  # cd ~/Desktop
}

initProjectFunc $1
if [ "$async" = "true" ]; then
  {
    gulpFunc & PID2=$!
    coreFunc & PID=$!
    gems_install & PID4=$!
    if [ "$npminstall" = "true" ]; then
      wait $PID2 &> /dev/null && echo "gulp: done"
    fi
  nodeModulesFunc
    if [ "$check" = "not_exist" ]; then
      gulpDependencies & PID3=$!
    fi
  } 
  wait $PID &> /dev/null && echo "core: done"
  if [ "$npminstall" = "false" ]; then
    wait $PID2 &> /dev/null && echo "gulp: done"
  fi
  wait $PID3 &> /dev/null && echo "gulp dependencies: done"
  wait $PID4 &> /dev/null && echo "gems: done"
  runNpmGulp
else
  gulpFunc
  coreFunc
  nodeModulesFunc
  if [ "$check" = "not_exist" ]; then
    gulpDependencies
  fi
  gems_install
  runNpmGulp
fi
# { coreFunc & PID=$!; } &> /dev/null && { gulpFunc & PID2=$!; } &> /dev/null
