#OPTIONS
#Change gulp_directory variable to gulp directory
#if variable does not contain directory path - gulp will be download from "git@gitlab.com:StudiaUtEdamVivo/gulp.git"
gulp_directory="git"
# gulp_directory="I://Dropbox/CODE/templates/gulp/"

core_dir="git"
# core_dir="I://Dropbox/CODE/core/"

#SCRIPT, do not change
#Functions
create_project_dir()
{
  echo "Project name: "
  read project_name
}

gems_install()
{
  gems=(compass susy breakpoint)
  for i in ${gems[*]}; do
    if gem list $i -i; then
      echo gem "$i" already installed
    else
      gem install $i
    fi
  done
}

success_func()
{
  echo "+ gulp created"

  npm install
  if [ $? -eq 0 ]; then
    echo "+ npm install"
  else
    echo "- fail then intall npm"
  fi
}

create_scaffold() 
{
  echo "create empty scaffold (y/n)?"
  read answer
  if [ "$answer" = "y" ]; then
    #create files in directory
    mkdir sass js images
    touch index.html sass/main.scss js/scripts.js 
    echo "+ empty html,js,sass,images created"
  fi
}

core_status="done"

if [ $1 ]; then
  project_name=$1
else
  create_project_dir
fi
while [ -d $project_name ]
do
  echo "- this name already exist, try again"
  create_project_dir
done
echo "--------------"

#create project directory
mkdir $project_name
echo "+ project directory created"
cd $project_name

if [ "$core_dir" = "git" ]; then
  git clone git@gitlab.com:StudiaUtEdamVivo/core.git

  if [ $? -eq 0 ]; then
    rm core/README.md && rm -rf core/.git
    mv core/* ./
    # mv ./core/{index.html,sass,js} ./
    rm -rf core
    mkdir images
    echo "+ html,js,sass,images cloned"
  else
    echo "- fail to clone core"
    create_scaffold
  fi
else
  # cp ${core_dir}index.html ./ && cp -rf ${core_dir}sass/ ./sass/ && cp -rf ${core_dir}js/ ./js/
  cp -r ${core_dir}* ./

  if [ $? -eq 0 ]; then
    rm README.md
    echo "+ html,js,sass,images copied"
  else
    echo "fail to copy files"
    create_scaffold
    core_status="fail"
  fi
fi

#module bundler
if [ "$gulp_directory" = "git" -a "$core_status" = "done" ]; then
  git clone git@gitlab.com:StudiaUtEdamVivo/gulp.git

  if [ $? -eq 0 ]; then
    mv ./gulp/{config.rb,gulpfile.js,package.json} ./
    rm -rf gulp
    success_func
  else
    echo "- fail to clone gulp repository"
    core_status="fail"
  fi
else
  cp ${gulp_directory}{gulpfile.js,config.rb,package.json} ./

  if [ $? -eq 0 ]; then
    success_func
  else
    echo "- fail to clone gulp files"
    core_status="fail"
  fi
fi


#log info
echo "========"
echo "all done"
echo "log:"
ls -la

if [ "$core_status" = "done" ]; then
  gems_install
  echo "run gulpw? (y/n)"
  read -n 1 answer2
  if [ "$answer2" = "y" ]
  then
    echo -e "\nok > gulp starting"
    npm run gulp && npm run gulp watch
  fi
fi
