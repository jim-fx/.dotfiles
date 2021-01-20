# Helps navigating COCO directory
function co(){

  cd ~/COCO

  openCode=false

  if [ "$1" = "o" ]; then
    1=$2;
    openCode=true
  fi

  first_dir=${1%/*};
  second_dir=${1#*/};

  if [ -z $first_dir ]; then
    first_dir=""
  fi

  if [ -z $second_dir ]; then
    second_dir=""
  fi

  if [ ! -v $first_dir ]; then
    coco_dir=$(ls | grep $first_dir | head -n 1)

    if [ -z "$coco_dir" ]; then

	echo "No directory exists for course $first_dir. Create a new one? (y/n)"

	read createDir

	if [ "$createDir" = "y" ]; then
		echo "What should the name be?"
		read dirName
		dirName=$first_dir"_$dirName"
		mkdir $dirName
		cd $dirName
		echo "Created $dirName"
	fi
	

    else

      cd $coco_dir
      amount=$(find ./* -maxdepth 0 -type d | wc -l)
      
      if [ "$amount" = "1" ]; then
        dir=$(find ./* -maxdepth 0 -type d)
        cd $dir
      fi

    fi

      if [ $second_dir != $first_dir ]; then
        cd $second_dir
      fi

    fi

    if [ $openCode = true ]; then
      code-insiders .
    fi

  }